from typing import Any
from PIL import Image
import os
from math import ceil, sqrt
import cairosvg
import io
import numpy as np
import xml.etree.ElementTree as ET
from PIL.ImageFile import ImageFile


def make_atlas(processed_images: dict, target_sizes: list, output_folder, output_path):
    for size in target_sizes:
        size_images = {key: i[size] for key, i in processed_images.items()}
        atlas_dimension = ceil(sqrt(len(size_images)))
        atlas_size = atlas_dimension * size

        atlas = Image.new('RGBA', (atlas_size, atlas_size), (255, 255, 255, 0))

        icon_positions = {}

        current_index = 0
        for svg_file, image in size_images.items():
            row = current_index // atlas_dimension
            col = current_index % atlas_dimension

            x = col * size
            y = row * size

            atlas.paste(image, (x, y), image)

            icon_positions[svg_file] = (col, row)
            current_index += 1

        atlas.save(
            f'{output_folder}/{output_path}_{size}.png',
            format='PNG',
            optimize=False,
            compress_level=0)

def process_svg(svg_path: str, target_sizes: list = [256], replace_black=True) -> dict[Any, ImageFile]:
    """
    Process an SVG file with color inversion and border checking.

    Args:
        svg_path: Path to the SVG file
        target_size: Desired size of the output image

    Returns:
        PIL Image object of the processed SVG
    """
    png_dict = {}
    # First convert SVG to PNG in memory with white fill
    # Replace black with white in the SVG content
    with open(svg_path, 'r') as f:
        svg_content = f.read()
    if replace_black:
        svg_content = svg_content.replace('/>', ' style="fill:#ffffff"/>')

    # Convert to PNG with cairosvg
    png_data = cairosvg.svg2png(
        bytestring=svg_content.encode('utf-8'),
        output_width=256,
        output_height=256,
        background_color="transparent"
    )

    # Convert to PIL Image
    image = Image.open(io.BytesIO(png_data))
    image = image.convert('RGBA')

    # Check borders for non-transparent pixels
    has_border_content = check_borders(image)

    if has_border_content:
        # Parse the SVG
        tree = ET.ElementTree(ET.fromstring(svg_content))
        root = tree.getroot()

        viewBox = root.get('viewBox')
        if viewBox:
            minx, miny, width, height = map(float, viewBox.split())
        else:
            width = float(root.get('width', '100').rstrip('px'))
            height = float(root.get('height', '100').rstrip('px'))
            root.set('viewBox', f'0 0 {width} {height}')

        # Calculate scaling factor to fit content within 246x246
        scale = 246 / max(width, height)
        new_width = width * scale
        new_height = height * scale

        # Calculate padding to center within 256x256
        pad_x = (256 - new_width) / 2
        pad_y = (256 - new_height) / 2

        # Create a new SVG root with padding
        new_root = ET.Element('svg', {
            'xmlns': 'http://www.w3.org/2000/svg',
            'viewBox': '0 0 256 256',
            'width': '256',
            'height': '256'
        })

        # Create a group to hold the original content, scaled and translated
        group = ET.SubElement(new_root, 'g', {
            'transform': f'translate({pad_x},{pad_y}) scale({scale})'
        })

        for child in list(root):
            group.append(child)

        # Convert modified SVG to string
        svg_content = ET.tostring(new_root, encoding='unicode')

    for size in target_sizes:
        # Final conversion to PNG
        png_bytes = cairosvg.svg2png(
            bytestring=svg_content.encode('utf-8'),
            output_width=size,
            output_height=size,
            background_color="transparent"
        )
        png_dict[size] = Image.open(io.BytesIO(png_bytes)).convert('RGBA')

    return png_dict


def check_borders(image: Image.Image, border_size: int = 10) -> bool:
    """
    Check if there are any non-transparent pixels in the border area.

    Args:
        image: PIL Image to check
        border_size: Size of border to check in pixels

    Returns:
        True if there are non-transparent pixels in the border
    """
    alpha = np.array(image.split()[3])  # Get alpha channel

    # Check top and bottom borders
    top_border = alpha[:border_size, :].any()
    bottom_border = alpha[-border_size:, :].any()

    # Check left and right borders
    left_border = alpha[:, :border_size].any()
    right_border = alpha[:, -border_size:].any()

    return top_border or bottom_border or left_border or right_border


def build_sql_def(master_files: list, target_sizes: list, output_path: str, modder: str, iconType: str):
    sql_icons = "INSERT INTO IconDefinitions(Name, Atlas, 'Index')VALUES\n"
    sql_atlas = "INSERT INTO IconTextureAtlases(Name, IconSize, IconsPerRow, IconsPerColumn, Filename) VALUES\n"
    for idx, atlas_files in enumerate(master_files):
        atlas_file_path = f'{output_path}_{idx}'
        atlas_name = f'ICON_{output_path.upper()}_{str(idx)}'
        for i, icon_unit in enumerate(atlas_files):
            icon_unit_fmt = icon_unit.replace('.svg', '').replace('.png', '')
            sql_icons += f"('{icon_unit_fmt}', '{atlas_name}', {i}),\n".replace('ICON_UNIT', f'ICON_{modder}UNIT').replace('ICON_EQUIPMENT', 'ICON_SLTH_EQUIPMENT')

        atlas_rows = ceil(sqrt(len(atlas_files)))
        for i, size in enumerate(target_sizes):
            sql_atlas += f"('{atlas_name}', '{size}', '{atlas_rows}', '1', '{atlas_file_path}_{size}.dds'),\n".replace(
                '.svg', '')
    sql_icons = sql_icons[:-2] + ';\n\n'
    sql_atlas = sql_atlas[:-2] + ';'
    sql_icons += sql_atlas
    with open(f'{iconType}_Icons.sql', 'w') as file:
        file.write(sql_icons)


def create_atlas_from_svgs(svg_files: list, svg_folder: str, output_path: str = "atlas.png", output_folder: str = "Atlas", target_sizes: list = [256]) -> dict:
    """
    Creates an atlas from SVG files after processing them.

    Args:
        svg_files: list of svgs to process in folder
        svg_folder: Path to the folder containing SVG files
        output_path: Path where the atlas will be saved
        output_folder: folder where atlas saved
        target_sizes = specifications of each atlas and the size of an element icon
    Returns:
        Dictionary mapping icon filenames to their positions in the atlas
    """
    num_icons = len(svg_files)

    if num_icons == 0:
        raise ValueError("No SVG files found in the specified folder")

    processed_images = {}
    for svg_file in svg_files:
        svg_path = os.path.join(svg_folder, svg_file)
        try:
            processed_images[svg_file] = process_svg(svg_path, target_sizes)
        except Exception as e:
            print(f"Error processing {svg_file}: {e}")
            continue

        make_atlas(processed_images, target_sizes, output_folder, output_path)


def create_atlas(icon_folder: str, icon_size: int = 256, output_path: str = "atlas", output_folder: str = 'Atlas', target_sizes: list = [256], modder: str= '', iconType: str = '') -> dict:
    """
    Creates a high-quality atlas from individual icon files with transparency.
    Handles both PNG and SVG files.

    Args:
        icon_folder: Path to the folder containing icon files
        icon_size: Size of each icon (assumes square icons)
        output_path: base Path where the atlas will be saved
        output_folder: Folder where atlases are deposited
        target_sizes: specifications of each atlas and the size of an element icon

    Returns:
        Dictionary mapping icon filenames to their positions in the atlas as (x, y) coordinates
    """
    # Check if we're dealing with SVGs
    MAX_ATLAS_COUNT = 64
    svg_files = [f for f in os.listdir(icon_folder) if f.endswith('.svg')]
    if svg_files:
        if len(svg_files) > MAX_ATLAS_COUNT:
            master_files = [svg_files[i:i + MAX_ATLAS_COUNT] for i in range(0, len(svg_files), MAX_ATLAS_COUNT)]
        else:
            master_files = [svg_files]
        for idx, atlas_files in enumerate(master_files):
            atlas_file_path = f'{output_path}_{idx}'
            create_atlas_from_svgs(atlas_files, icon_folder, atlas_file_path, output_folder, target_sizes)

        build_sql_def(master_files, target_sizes, output_path, modder, iconType)
    else:
        icon_files = [f for f in os.listdir(icon_folder) if f.endswith('.png')]
        if len(icon_files) > MAX_ATLAS_COUNT:
            master_files = [icon_files[i:i + MAX_ATLAS_COUNT] for i in range(0, len(icon_files), MAX_ATLAS_COUNT)]
        else:
            master_files = [icon_files]

        for idx, atlas_files in enumerate(master_files):
            indexed_output_path = f'{output_path}_{idx}'
            num_icons = len(atlas_files)
            if num_icons == 0:
                raise ValueError("No PNG files found in the specified folder")
            processed_images = {}
            for filepath in atlas_files:
                extended_filepath = f'{icon_folder}/{filepath}'
                png_dict = {}
                initial_image = Image.open(extended_filepath).convert('RGBA')
                for size in target_sizes:
                    png_dict[size] = initial_image.resize((size, size), Image.Resampling.LANCZOS)
                processed_images[filepath] = png_dict

            make_atlas(processed_images, target_sizes, output_folder, indexed_output_path)

        build_sql_def(master_files, target_sizes, output_path, modder, iconType)

def get_icon_coordinates(position: tuple, icon_size: int = 256) -> tuple:
    """
    Converts atlas position to pixel coordinates.

    Args:
        position: (column, row) position in the atlas
        icon_size: Size of each icon

    Returns:
        Tuple of ((x1, x2), (y1, y2)) coordinates for the icon in the atlas
    """
    col, row = position
    x1 = col * icon_size
    y1 = row * icon_size
    x2 = x1 + icon_size
    y2 = y1 + icon_size

    return ((x1, x2), (y1, y2))


if __name__ == "__main__":
    # Set these constants to what you want them to be
    # Expects an input folder with only .svg or .png files in it, named like ICON_UNIT_WARRIOR

    # ATLAS_FILENAME = 'Slth_Units_Atlas'
    # INPUT_FOLDER = 'atlas_wd_svg'
    # OUTPUT_FOLDER = 'Unit_Atlas'
    # ICON_TYPE = 'UNIT'
    # TARGET_SIZES = [256, 80, 50, 38, 32, 22]

    ATLAS_FILENAME = 'Slth_Resource_Atlas'
    INPUT_FOLDER = 'atlas_wd_rsc'
    OUTPUT_FOLDER = 'Resource_Atlas_Folder'
    ICON_TYPE = 'RESOURCE'
    TARGET_SIZES = [256, 64, 50, 38, 32, 22]

    MODDER_TAG = 'SLTH_'
    if not os.path.exists(OUTPUT_FOLDER):
        os.makedirs(OUTPUT_FOLDER)
    create_atlas(INPUT_FOLDER, 256, ATLAS_FILENAME, OUTPUT_FOLDER, TARGET_SIZES, MODDER_TAG, ICON_TYPE)
