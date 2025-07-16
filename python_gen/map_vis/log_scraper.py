from PIL import Image, ImageOps, ImageDraw, ImageFont
import os
import colorsys
import math
import collections


def parse_log(filepath):
    with open(filepath, 'r') as f:
        lines = f.readlines()

    grids = {}
    current_grid = []
    inside_map = False
    count = 0
    filename = '0'
    for line in lines:
        if "Map Script: START" in line:
            inside_map = True
            current_grid = []
            splitter = line.split('; ')
            if len(splitter) == 2:
                filename = splitter[1]
            else:
                filename = str(count)
                count += 1
            continue
        elif "Map Script: STOP" in line:
            if current_grid:
                grids[filename] = current_grid
            inside_map = False
            continue

        if inside_map and line.startswith("Map Script:"):
            data = line.strip().replace("Map Script:", "").strip()
            if data:
                row = data.split("|")
                current_grid.append(row)

    return grids

color_map = {   "0":(0, 0, 255),
        "3": (255, 0, 0),
        "2": (255, 255, 0),
        "1": (0, 255, 0),
        0: (0, 0, 255),
        3: (255, 0, 0),
        2: (255, 255, 0),
        1: (0, 255, 0),
    }
def save_color_grid(grid, filename, output_dir):
    # --- MODIFICATION: Added a scale factor ---
    SCALE_FACTOR = 4

    new_grid = grid.copy()
    max_width = 0
    for idx, i in enumerate(new_grid):
        for id_x, j in enumerate(i):
            new_grid[idx][id_x] = j.replace('-', '').replace('|', '')
            if 5 > len(new_grid[idx][id_x]) > 1:
                new_grid[idx][id_x] = chr(int(new_grid[idx][id_x][-1]) + 73)

    if new_grid:
        max_width = max(sum(len(cell) for cell in row) for row in new_grid)

    max_height = len(new_grid)

    KEY_HEIGHT = 40
    PADDING = 10
    SWATCH_SIZE = 15
    FONT_SIZE = 15

    # --- MODIFICATION: Scale the image dimensions ---
    scaled_width = max_width * SCALE_FACTOR
    scaled_height = max_height * SCALE_FACTOR

    img = Image.new(
        'RGB',
        (scaled_width, scaled_height + KEY_HEIGHT),  # Use scaled dimensions
        color=(255, 255, 255)
    )
    draw = ImageDraw.Draw(img)  # Create draw object early
    new_color_map = {'I': (255, 0, 0), '0': (0, 0, 255), '1': (0, 255, 0), '3': (255, 125, 0)}
    # (Color map generation logic remains the same)
    unique_chars = sorted(set(char for row in new_grid for cell_str in row for char in cell_str))
    all_chars = sorted(list(set(unique_chars) | {'*'}))
    uncolored_chars = [char for char in all_chars if char not in new_color_map]
    char_to_color = {char: (i * 25 % 256, i * 50 % 256, i * 75 % 256) for i, char in enumerate(uncolored_chars)}
    char_to_color.update(new_color_map)
    char_to_color['*'] = (200, 200, 200)

    # --- MODIFICATION: Draw scaled rectangles instead of pixels ---
    for y, row_data in enumerate(new_grid):
        current_x = 0
        for cell_string in row_data:
            chars = list(cell_string) if cell_string else ['*']
            for char in chars:
                char_color = char_to_color.get(char, (0, 0, 0))

                # Calculate coordinates for the scaled rectangle
                x0 = current_x * SCALE_FACTOR
                y0 = y * SCALE_FACTOR
                x1 = x0 + SCALE_FACTOR
                y1 = y0 + SCALE_FACTOR

                # Draw the rectangle
                draw.rectangle([x0, y0, x1, y1], fill=char_color)

                current_x += 1

    # img = img.rotate(180)
    # img = ImageOps.mirror(img)

    # Draw the color key (font loading)
    try:
        font = ImageFont.truetype("arial.ttf", FONT_SIZE)
    except IOError:
        font = ImageFont.load_default()

    key_x_pos = PADDING
    # --- MODIFICATION: Adjust key's Y position to be below the scaled grid ---
    key_y_pos = scaled_height + PADDING

    for char, color in sorted(char_to_color.items()):
        # Draw swatch
        swatch_coords = [key_x_pos, key_y_pos, key_x_pos + SWATCH_SIZE, key_y_pos + SWATCH_SIZE]
        draw.rectangle(swatch_coords, fill=color, outline=(0, 0, 0))

        # Draw text
        text = f"{char}"
        text_coords = (key_x_pos + (SWATCH_SIZE/4), key_y_pos)
        draw.text(text_coords, text, fill=(0, 0, 0), font=font)
        key_x_pos += SWATCH_SIZE

    # Final transformations and saving (unchanged)
    os.makedirs(output_dir, exist_ok=True)
    file_name = os.path.join(output_dir, f'grid_{filename.strip().replace("?", "_")}.png')
    img.save(file_name)


def _generate_hex_image(grid, basename, output_dir, hex_size=25, color_map=None):
    if color_map is None:
        color_map = {}

    # Pre-process the grid to handle cells with multiple characters, if its all one row stupidly.
    # Each character becomes its own cell in the processed grid.
    # e.g., [['ab', 'c']] becomes [['a', 'b', 'c']]
    if len(grid[0][0]) > 5:
        processed_grid = [[char for cell_str in row for char in cell_str] for row in grid]
    else:
        processed_grid = grid

    if not any(processed_grid):
        print(f"Warning: Grid for '{basename}' is empty. Skipping image generation.")
        return

    # --- 1. Setup Colors ---
    # Find all unique characters in the grid to assign colors.
    unique_chars = sorted(set(char for row in processed_grid for char in row))

    # Create the final color mapping.
    char_to_color = {char: color for char, color in color_map.items()}

    # Generate colors for characters not already in the provided color_map.
    chars_to_generate = [char for char in unique_chars if char not in char_to_color]
    new_colors = generate_contrasting_colors(len(chars_to_generate))
    char_to_color.update(dict(zip(chars_to_generate, new_colors)))

    # Assign a specific color for empty cells or background.
    char_to_color['*'] = (255, 255, 255)  # White for empty/background

    # --- 2. Calculate Geometry and Canvas Size ---
    padding = hex_size
    num_rows = len(processed_grid)
    num_cols = max(len(r) for r in processed_grid) if num_rows > 0 else 0

    # Calculate image dimensions based on orientation.
    hex_width = math.sqrt(3) * hex_size
    hex_height = 2 * hex_size
    img_width = int(hex_width * num_cols + hex_width / 2 + padding * 2)
    img_height = int(hex_height * 0.75 * (num_rows - 1) + hex_height + padding * 2)

    # Create the image and drawing context.
    img = Image.new('RGB', (img_width, img_height), char_to_color['*'])
    draw = ImageDraw.Draw(img)

    # --- 3. Draw Hexagons ---
    for r, row in enumerate(reversed(processed_grid)):
        for c, char in enumerate(row):
            # Calculate the center of the hexagon.
            col_offset = hex_width / 2 if r % 2 != 0 else 0
            center_x = padding + (c * hex_width) + col_offset
            center_y = padding + (r * hex_height * 0.75)

            points = []
            for i in range(6):
                angle_deg = 60 * i - 30
                angle_rad = math.pi / 180 * angle_deg
                points.append((
                    center_x + hex_size * math.cos(angle_rad),
                    center_y + hex_size * math.sin(angle_rad)
                ))

            # Draw the hexagon with an outline.
            fill_color = char_to_color.get(char, (0, 0, 0))  # Default to black
            draw.polygon(points, fill=fill_color, outline=(50, 50, 50))

    # --- 4. Save Image ---
    os.makedirs(output_dir, exist_ok=True)
    safe_basename = basename.strip().replace("?", "_").replace(" ", "_")
    file_path = os.path.join(output_dir, f'grid_{safe_basename}.png')
    img.save(file_path)
    print(f"Saved grid to {file_path}")


def save_region_color_grid(grid, basename, output_dir, blockers, hex_size=20):
    """
    Identifies and saves a color-coded image of distinct regions in a
    pointy-topped hexagonal grid.

    A region is defined as a set of connected plots. Movement between plots is
    blocked by any plot containing the character 'M'.

    Args:
        grid (list[list[str]]): The grid data, as a list of rows.
        basename (str): The base name for the output file.
        output_dir (str): The directory where the image will be saved.
        hex_size (int, optional): The size (radius) of each hexagon. Defaults to 20.
    """
    # --- 1. Pre-process Grid and Initialize ---
    # As before, ensure each character is its own cell.
    processed_grid = [[char for cell_str in row for char in cell_str] for row in grid]
    if not any(processed_grid):
        print(f"Warning: Grid for '{basename}' is empty. Skipping region analysis.")
        return

    num_rows = len(processed_grid)
    # Store the length of each row for boundary checks
    row_lengths = [len(r) for r in processed_grid]

    # This grid will store the integer ID for each region.
    region_grid = [[None for _ in col] for col in processed_grid]
    visited = set()

    # --- 3. Find and Label All Regions (Flood Fill) ---
    current_region_id = 0
    for r in range(num_rows):
        for c in range(row_lengths[r]):
            # If we've already seen this plot or it's an obstacle, skip it.
            if (r, c) in visited or processed_grid[r][c] in blockers:
                continue

            # Found the start of a new region!
            q = collections.deque([(r, c)])
            visited.add((r, c))
            region_grid[r][c] = str(current_region_id)

            # Start Breadth-First Search (BFS) to find all connected plots.
            while q:
                curr_r, curr_c = q.popleft()
                for neighbor_r, neighbor_c in get_valid_neighbors(curr_r, curr_c, num_rows, row_lengths):
                    # Check if the neighbor is valid for the current region.
                    if (neighbor_r, neighbor_c) not in visited and \
                            processed_grid[neighbor_r][neighbor_c] not in blockers:
                        visited.add((neighbor_r, neighbor_c))
                        region_grid[neighbor_r][neighbor_c] = str(current_region_id)
                        q.append((neighbor_r, neighbor_c))

            # Finished this region, move to the next ID.
            current_region_id += 1

    # --- 4. Prepare for Drawing ---
    # Label the 'M' obstacle plots in the final region grid.
    for r in range(num_rows):
        for c in range(row_lengths[r]):
            if processed_grid[r][c] in blockers:
                region_grid[r][c] = processed_grid[r][c]

    # Create a color map for the regions and obstacles.
    num_regions = current_region_id
    colors = generate_contrasting_colors(num_regions)  # Assumes this helper exists

    color_map = {str(i): colors[i] for i in range(num_regions)}
    block_int = 80
    for i in blockers:
        color_map[i] = (block_int, block_int, block_int)  # Dark grey for mountains/obstacles
        block_int += 40

    # --- 5. Generate the Image ---
    print(f"Found {num_regions} distinct regions.")
    # We call the existing drawing function with our newly created region grid.
    _generate_hex_image(
        grid=region_grid,
        basename=f"{basename}_regions",
        output_dir=output_dir,
        hex_size=hex_size,
        color_map=color_map
    )

def generate_contrasting_colors(n):
    """
    Generates a list of visually distinct RGB colors, up to 30.
    Colors are spaced to maximize contrast, especially for smaller 'n'.
    """
    colors = []
    golden_ratio_conjugate = 0.618033988749895           # Golden ratio conjugate for good distribution of hues
    # Base saturation and value for bright colors
    base_saturation = 0.9
    base_value = 0.95

    # Adjustments for saturation and value to add more variety
    s_levels = [base_saturation, base_saturation * 0.75] # High and slightly lower saturation
    v_levels = [base_value, base_value * 0.85] # High and slightly lower value

    for i in range(n):
        hue = (i * golden_ratio_conjugate) % 1.0        # Calculate hue using golden ratio for good spacing

        # Cycle through saturation and value levels for more distinctness
        saturation = s_levels[i % len(s_levels)]
        value = v_levels[i % len(v_levels)]

        rgb_float = colorsys.hsv_to_rgb(hue, saturation, value)
        colors.append(tuple(int(c * 255) for c in rgb_float))

    return colors

def get_valid_neighbors(r, c, num_rows, row_lengths):
    """Calculates the 6 neighbor coordinates for a pointy-topped grid."""
    # Neighbor coordinates depend on whether the row is even or odd.
    if r % 2 == 0:  # Even rows
        candidates = [
            (r, c - 1), (r, c + 1),  # W, E
            (r - 1, c - 1), (r - 1, c),  # NW, NE
            (r + 1, c - 1), (r + 1, c)  # SW, SE
        ]
    else:  # Odd rows
        candidates = [
            (r, c - 1), (r, c + 1),  # W, E
            (r - 1, c), (r - 1, c + 1),  # NW, NE
            (r + 1, c), (r + 1, c + 1)  # SW, SE
        ]

    # Filter out neighbors that are outside the grid boundaries.
    valid_neighbors = []
    for nr, nc in candidates:
        if 0 <= nr < num_rows and 0 <= nc < row_lengths[nr]:
            valid_neighbors.append((nr, nc))
    return valid_neighbors


class RegionMap:

    def __init__(self, hex):
        self.absorbed_into_region = []
        self.blocker_map = []
        self.num_rows = 0
        self.row_lengths = []
        self.current_tiles_in_region = 0
        self.isHex = hex

    def get_grid_regions(self, grid, blockers):
        new_grid = [row[:] for row in grid]
        # Consistent format. Make mountains always -2, and water -3.
        mountain_mapper = {'6': -3, '1': -2, 'W': -2, 'M': -3, 'P':-2, 'O':-3}
        for y, row in enumerate(new_grid):
            for x, tile in enumerate(row):
                row[x] = mountain_mapper.get(tile, tile)

        self.num_rows = len(new_grid)
        self.row_lengths = [len(r) for r in new_grid]
        self.absorbed_into_region = [[-1 if j not in blockers else j for j in i] for i in new_grid]

        current_region = 1
        for y, row in enumerate(new_grid):
            for x, tile in enumerate(row[:-1]):
                if self.absorbed_into_region[y][x] == -1:
                    self.current_tiles_in_region = 0                 # Reset counter and build the new region
                    self.build_region(x, y, current_region)
                    current_region += 1

        return self.absorbed_into_region

    def get_valid_neighbors(self, y, x):
        if self.isHex:
            if y % 2 == 0:  # Even rows
                candidates = [
                    (y, x - 1), (y, x + 1),  # W, E
                    (y - 1, x - 1), (y - 1, x),  # NW, NE
                    (y + 1, x - 1), (y + 1, x)  # SW, SE
                ]
            else:  # Odd rows
                candidates = [
                    (y, x - 1), (y, x + 1),  # W, E
                    (y - 1, x), (y - 1, x + 1),  # NW, NE
                    (y + 1, x), (y + 1, x + 1)  # SW, SE
                ]

            valid_neighbors = []
            for nr, nc in candidates:
                if 0 <= nr < self.num_rows and 0 <= nc < self.row_lengths[nr]:
                    valid_neighbors.append((nr, nc))
        else:
            candidates = [(y, x+1), (y, x-1), (y+1, x), (y-1, x),             # cardinal
                          (y+1, x+1), (y+1, x-1), (y-1, x+1), (y-1, x-1)]     # diagonal
            valid_neighbors = []
            for nr, nc in candidates:
                if 0 <= nr < self.num_rows and 0 <= nc < self.row_lengths[nr] -1:
                    valid_neighbors.append((nr, nc))

        return valid_neighbors

    def build_region(self, start_x, start_y, current_region):
        """
        Iteratively builds a region using a stack (via a list) to avoid recursion.
        This is a non-recursive flood-fill algorithm.
        """
        # A stack to hold the coordinates of tiles to visit. Start with the initial tile.
        # Using collections.deque is often faster for appends and pops.
        stack = collections.deque([(start_x, start_y)])

        # Process tiles as long as there are items in the stack
        while stack:
            x, y = stack.pop()
            # Check if the tile has already been assigned. If so, skip.
            if self.absorbed_into_region[y][x] != -1:
                continue
            # Assign the tile to the current region
            self.absorbed_into_region[y][x] = current_region
            self.current_tiles_in_region += 1
            # Get all valid neighbors
            adjacent_plots = self.get_valid_neighbors(y, x)
            for new_y, new_x in adjacent_plots:
                # If a neighbor hasn't been assigned a region yet, add it to the stack
                if self.absorbed_into_region[new_y][new_x] == -1:
                    stack.append((new_x, new_y))

def main(filepath, output_dir='grids_out'):
    os.makedirs(output_dir, exist_ok=True)
    grids = parse_log(filepath)
    blockers = [-3, -2, '6', '1', 'W', 'M']
    for file_name, grid in grids.items():
        if len(file_name) > 3:
            new_grid = list(reversed(grid))
        else:
            new_grid = grid
        if 'RESULT' in file_name:
            if 'plot' in file_name and 'FINAL' not in file_name:
                _generate_hex_image(new_grid, file_name, 'output_images')
                if any(any(k in blockers for k in j) for j in new_grid):
                    AreaMap = RegionMap(hex=True)
                    mountain_and_sea = AreaMap.get_grid_regions(new_grid, blockers)
                    mountain_and_sea = [[str(j) for j in i] for i in mountain_and_sea]
                    _generate_hex_image(mountain_and_sea, f"{file_name.strip()}_mountain_and_sea_blockers", 'areas')
                    if any(any(k in [-2, '1', 'M'] for k in j) for j in new_grid):
                        areaMap_Two = RegionMap(hex=True)
                        mountain = areaMap_Two.get_grid_regions(new_grid, [-2, '1', 'M'])
                        mountain = [[str(j) for j in i] for i in mountain]
                        _generate_hex_image(mountain, f"{file_name.strip()}_mountain_blockers", 'areas')
            else:
                print('')
                _generate_hex_image(new_grid, file_name, output_dir)

        else:
            save_color_grid(new_grid, file_name, output_dir)
            if 'square' in file_name:
                square_blockers = ['P', 'O']
                grid[0][0] += 'P'                    # TODO REMOVE just adding synthetic data so it works
                converted_grid = [list(i[0]) for i in new_grid]
                AreaMap = RegionMap(hex=False)
                mountain_and_sea = AreaMap.get_grid_regions(converted_grid, blockers)
                regions_old_form = [[chr(97 + j) for j in i] for i in mountain_and_sea]
                regions_old_form = [["".join(j for j in i)] for i in regions_old_form]
                save_color_grid(regions_old_form, f"{file_name.strip()}_mountain_and_sea_blockers", 'areas')
                areaMap_Two = RegionMap(hex=False)
                mountain = areaMap_Two.get_grid_regions(converted_grid, [-2, '1', 'M'])
                regions_old_form = [[chr(97 + j) for j in i] for i in mountain]
                regions_old_form = [["".join(j for j in i)] for i in regions_old_form]
                save_color_grid(regions_old_form, f"{file_name.strip()}_mountain_blockers", 'areas')




main("C:/Users/Sam/AppData/Local/Firaxis Games/Sid Meier's Civilization VI/Logs/Lua.log")
