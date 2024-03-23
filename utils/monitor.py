import time
import shutil
import os
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler
from threading import Timer

# Define the paths
log_file_path = "C:/Users/Sam/AppData/Local/Firaxis Games/Sid Meier's Civilization VI/Logs/Database.log"
destination_path = "C:/Users/Sam/Documents/my games/Sid Meier's Civilization VI/Mods/unit addition dissection/utils/Database.log"
# db_path = ""
# db_destination_path = "C:/Users/Sam/Documents/my games/Sid Meier's Civilization VI/Mods/unit addition dissection/utils/"
get_rid_of_logs = ['StartupErrorMessages.xml', 'Configuration', 'Localization', 'FullTextSearch']


def process_log_file(log_file_path):
    # Do your string processing here
    with open(log_file_path, 'r') as f:
        log_data = f.readlines()
        # less_logs = [i for i in log_data if not any([i in j for j in get_rid_of_logs]) in i]
        less_logs = [i for i in log_data if 'Gameplay' in i]
        # Example processing: convert all text to uppercase
    # Write processed data back to the log file
    with open(log_file_path, 'w') as f:
        f.write(less_logs)


# Define the event handler for file changes
class LogFileHandler(FileSystemEventHandler):
    def on_modified(self, event):
        if event.src_path == log_file_path:
            print("Log file has been modified, scheduling copy and processing...")

            # Define a function to copy and process the file after a delay
            def delayed_copy_and_process():
                print("Copying and processing file...")
                # Copy the log file to the destination folder
                shutil.copy(log_file_path, destination_path)
                # Process the copied log file
                process_log_file(os.path.join(destination_path, os.path.basename(log_file_path)))

            # Schedule the function to execute after a delay of one minute
            timer = Timer(60, delayed_copy_and_process)
            timer.start()


# Start monitoring the log file for changes
if __name__ == "__main__":
    event_handler = LogFileHandler()
    observer = Observer()
    observer.schedule(event_handler, path=os.path.dirname(log_file_path), recursive=False)
    observer.start()

    #observer_db = Observer()
    #observer_db.schedule(event_handler, path=os.path.dirname(log_file_path), recursive=False)
    #observer_db.start()
    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        observer.stop()
        #observer_db.stop()

    observer.join()
    #observer_db.join()
