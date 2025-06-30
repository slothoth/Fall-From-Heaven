from PIL import Image, ImageOps
import os
import colorsys


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

def main(filepath, output_dir='grids_out'):
    os.makedirs(output_dir, exist_ok=True)
    grids = parse_log(filepath)
    for file_name, grid in grids.items():
        save_color_grid(grid, file_name, output_dir)
#   save_color_grid_old(grid, i, output_dir)



main("C:/Users/Sam/AppData/Local/Firaxis Games/Sid Meier's Civilization VI/Logs/Lua.log")
