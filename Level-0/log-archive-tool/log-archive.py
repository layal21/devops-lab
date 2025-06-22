import os
import tarfile
from datetime import datetime
import sys

def archive_logs(logs_directory, archive_directory='archived_logs'):
    # Step 1: Create archive directory if it doesn't exist
    if not os.path.exists(archive_directory):
        os.makedirs(archive_directory)
        print(f"Created directory: {archive_directory}")

    # Step 2: Create tar.gz file from the logs_directory
    timestamp = datetime.now().strftime('%Y-%m-%d_%H-%M-%S')
    tar_filename = f"logs_backup_{timestamp}.tar.gz"
    tar_path = os.path.join(archive_directory, tar_filename)

    with tarfile.open(tar_path, "w:gz") as tar:
        tar.add(logs_directory, arcname=os.path.basename(logs_directory))
        print(f"Archived {logs_directory} to {tar_path}")

    return tar_path


def main():
    if len(sys.argv) != 2:
        print("Usage: log-archive <logs_directory>")
        sys.exit(1)

    logs_directory = sys.argv[1]

    if not os.path.isdir(logs_directory):
        print(f"Error: '{logs_directory}' is not a valid directory.")
        sys.exit(1)

    archive_logs(logs_directory)

if __name__ == "__main__":

    main()
    print("Log archiving completed successfully.")