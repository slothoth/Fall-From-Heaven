import shutil
import os


def main():
    # populate prebuilts
    source_directory = 'prebuilt'
    destination_directory = '../FallFromHeaven'

    all_directories = [d for d in os.listdir(source_directory) if os.path.isdir(os.path.join(source_directory, d))]
    all_files = [d for d in os.listdir(source_directory) if not os.path.isdir(os.path.join(source_directory, d))]
    for directory_name in all_directories:
        source_path = os.path.join(source_directory, directory_name)
        destination_path = os.path.join(destination_directory, directory_name)
        if os.path.exists(destination_path):
            shutil.rmtree(destination_path)
        shutil.copytree(source_path, destination_path)

    for file_name in all_files:
        source_path = os.path.join(source_directory, file_name)
        destination_path = os.path.join(destination_directory, file_name)
        shutil.copy(source_path, destination_path)

    mod_ = f'{destination_directory}/FallFromHeaven.mod'
    if os.path.exists(f'{mod_}info'):
        os.remove(f'{mod_}info')
    os.rename(f'{mod_}_info', f'{mod_}info')


if __name__ == "__main__":
    main()
