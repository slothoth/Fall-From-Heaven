from PIL import Image
import os


def process_image(input_path, output_path):
    # Open the image
    img = Image.open(input_path)

    # Convert to RGBA if not already
    if img.mode != 'RGBA':
        img = img.convert('RGBA')

    # Create new square image with transparent background
    new_img = Image.new('RGBA', (3900, 3900), (0, 0, 0, 0))

    # Calculate position to paste original image (centered)
    paste_x = (3900 - 3000) // 2
    paste_y = 0

    # Paste original image
    new_img.paste(img, (paste_x, paste_y))

    # High quality resize to 1024x1024
    # Lanczos resampling is generally considered the highest quality
    resized_img = new_img.resize((1024, 1024), Image.Resampling.LANCZOS)

    # Save the result
    resized_img.save(output_path, 'PNG')


def process_folder(input_folder, output_folder):
    # Create output folder if it doesn't exist
    if not os.path.exists(output_folder):
        os.makedirs(output_folder)

    # Process all images in the folder
    for filename in os.listdir(input_folder):
        if filename.lower().endswith(('.png', '.jpg', '.jpeg')):
            input_path = os.path.join(input_folder, filename)
            output_path = os.path.join(output_folder, f'{filename}')

            try:
                process_image(input_path, output_path)
                print(f"Successfully processed: {filename}")
            except Exception as e:
                print(f"Error processing {filename}: {str(e)}")


# Usage
input_folder = "HD-LeaderCollection"
output_folder = "HD-Leader_1k"
process_folder(input_folder, output_folder)
