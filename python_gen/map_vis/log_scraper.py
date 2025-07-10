from PIL import Image, ImageOps, ImageDraw
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

def save_color_grid_old(grid, index, output_dir):
    max_width = max(sum(len(cell) for cell in row) for row in grid)
    max_height = len(grid)
    img = Image.new('RGB', (max_width, max_height))

    unique_chars = sorted(set(a for row in grid for c in row for a in c))

    def generate_contrasting_colors(n):
        return [tuple(int(c * 255) for c in colorsys.hsv_to_rgb(i / n, 1, 1)) for i in range(n)]

    char_to_color = dict(zip(unique_chars, generate_contrasting_colors(len(unique_chars))))

    pixels = img.load()
    for y, x_row in enumerate(grid):
        for uh, x_string in enumerate(x_row):
            for x, val, in enumerate(x_string):
                pixels[x, y] = char_to_color[val]
    file_name = os.path.join(output_dir, f'grid_{index + 1}.png')
    img.save(file_name)

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
    max_width = 0
    for idx, i in enumerate(grid):
        grid[idx][0] = i[0].replace('-', '').replace('|', '')
    if grid:
        max_width = max(sum(len(cell) for cell in row) for row in grid)
    max_height = len(grid)
    img = Image.new('RGB', (max_width, max_height))
    unique_chars = sorted(set(char for row in grid for cell_str in row for char in cell_str))

    def generate_contrasting_colors(n_colors):
        colors = []
        for i in range(n_colors):
            # Use HSV to RGB conversion for better color distribution.
            r, g, b = colorsys.hsv_to_rgb(i / n_colors, 1, 1)
            colors.append(tuple(int(c * 255) for c in (r, g, b)))
        return colors

    # Map each unique character to a generated contrasting color.
    unique_chars = set(unique_chars)
    unique_chars -= set(color_map.keys())
    char_to_color = dict(zip(unique_chars, generate_contrasting_colors(len(unique_chars))))
    char_to_color.update(color_map)
    # Assign a specific color (white) to the '*' character, which is used for empty cells.
    # Note: RGB values should be between 0 and 255, so (256, 256, 256) is corrected to (255, 255, 255).
    char_to_color['*'] = (255, 255, 255)

    # Get the pixel access object for the image.
    pixels = img.load()

    # Iterate through each row (y-coordinate) of the grid.
    for y, row_data in enumerate(grid):
        current_x_pixel = 0  # This variable tracks the current horizontal pixel position in the image.

        # Iterate through each string element within the current row.
        # Example: if row_data is ['abc', 'd'], then 'abc' is one element, 'd' is another.
        for cell_string in row_data:
            # If the string element is empty, treat it as a single '*' character.
            if cell_string == '':
                # Ensure the current pixel position is within the image bounds before setting.
                if 0 <= current_x_pixel < max_width and 0 <= y < max_height:
                    pixels[current_x_pixel, y] = char_to_color['*']
                current_x_pixel += 1  # Move to the next pixel column.
            else:
                # Iterate through each individual character within the cell_string.
                # Example: if cell_string is 'abc', then 'a', 'b', 'c' are individual characters.
                for char in cell_string:
                    # Retrieve the color for the character from the map.
                    # Provide a fallback color (e.g., black) if a character somehow isn't mapped,
                    # although with the current logic, all unique chars should be mapped.
                    char_color = char_to_color.get(char, (0, 0, 0)) # Default to black if char not found

                    if 0 <= current_x_pixel < max_width and 0 <= y < max_height:
                        pixels[current_x_pixel, y] = char_color
                    current_x_pixel += 1  # Move to the next pixel column.

    os.makedirs(output_dir, exist_ok=True)
    file_name = os.path.join(output_dir, f'grid_{filename.strip().replace("?", "_")}.png')
    img = img.rotate(180)
    img = ImageOps.mirror(img)
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
    """Generates a list of visually distinct RGB colors."""
    colors = []
    for i in range(n):
        hue = i / n
        # Use saturation and value that produce bright, non-pastel colors.
        saturation, value = 0.9, 0.95
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

    def __init__(self):
        self.absorbed_into_region = []
        self.blocker_map = []
        self.num_rows = 0
        self.row_lengths = 0
        self.current_tiles_in_region = 0

    def get_grid_regions(self, grid, blockers):
        new_grid = grid.copy()
        # consistent format. Make mountains always -2, and water -3.
        mountain_mapper = {'6': -3, '1': -2, 'W': -2, 'M': -3}
        for id_x, i in enumerate(new_grid):
            for idx, j in enumerate(i):
                i[idx] = mountain_mapper.get(j, j)
            new_grid[id_x] = i
        self.num_rows = len(new_grid)
        self.row_lengths = [len(r) for r in new_grid]  # Store the length of each row for boundary checks
        # expansion
        self.absorbed_into_region = [[-1 if j not in blockers else j for j in i] for i in new_grid]
        current_region = 1
        for y, i in enumerate(new_grid):
            for x, j in enumerate(i):
                if self.absorbed_into_region[y][x] == -1:
                    self.build_region(x, y, current_region)
                    current_region += 1
                    self.current_tiles_in_region = 0
        return self.absorbed_into_region

    def get_valid_neighbors(self, y, x):
        """Calculates the 6 neighbor coordinates for a pointy-topped grid."""
        # Neighbor coordinates depend on whether the row is even or odd.
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

        # Filter out neighbors that are outside the grid boundaries.
        valid_neighbors = []
        for nr, nc in candidates:
            if 0 <= nr < self.num_rows and 0 <= nc < self.row_lengths[nr]:
                valid_neighbors.append((nr, nc))
        return valid_neighbors

    def build_region(self, x, y, current_region):
        # Find adjacent plots
        self.absorbed_into_region[y][x] = current_region
        self.current_tiles_in_region += 1
        adjacent_plots = self.get_valid_neighbors(y, x)
        for k in adjacent_plots:
            new_y, new_x = k
            plot_region = self.absorbed_into_region[new_y][new_x]
            if plot_region == -1:
                self.build_region(new_x, new_y, current_region)

def main(filepath, output_dir='grids_out'):
    os.makedirs(output_dir, exist_ok=True)
    grids = parse_log(filepath)
    blockers = [-3, -2, '6', '1', 'W', 'M']
    for file_name, grid in grids.items():
        if 'RESULT' in file_name:
            if 'plot' in file_name:
                _generate_hex_image(grid, file_name, 'output_images')
                if any(any(k in blockers for k in j) for j in grid):
                    AreaMap = RegionMap()
                    mountain_and_sea = AreaMap.get_grid_regions(grid, blockers)
                    mountain_and_sea = [[str(j) for j in i] for i in mountain_and_sea]
                    _generate_hex_image(mountain_and_sea, f"{file_name.strip()}_mountain_and_sea_blockers", 'areas')
                    if any(any(k in [-2, '1', 'M'] for k in j) for j in grid):
                        areaMap_Two = RegionMap()
                        mountain = areaMap_Two.get_grid_regions(grid, [-2, '1', 'M'])
                        mountain = [[str(j) for j in i] for i in mountain]
                        _generate_hex_image(mountain, f"{file_name.strip()}_mountain_blockers", 'areas')
            else:
                print('')
                _generate_hex_image(grid, file_name, output_dir)

        else:
            save_color_grid(grid, file_name, output_dir)



main("C:/Users/Sam/AppData/Local/Firaxis Games/Sid Meier's Civilization VI/Logs/Lua.log")
