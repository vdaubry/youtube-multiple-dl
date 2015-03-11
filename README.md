Multiple downloads in parralel for youtube-dl

youtube-multiple-dl
===================


This project is a lightweight job queue around youtube-dl. It provides command line interface to : 

1 - Start multiple process to downloads multiple url content in parallel with youtube-dl
2 - Manage the queue : add URL to the queue, delete, list, etc


## Benefit :

There are several benefit to using a job queue instead of a text file to store URLs to downloads :

- Retries : In case a download fails it will be automatically retried
- Priority : you can order the importance of downloads by setting a priority level to the URL you add to the queue


## Requirements :

[youtube-dl](https://github.com/rg3/youtube-dl) must be installed. To ensure it is available, on your command line, run `which youtube-dl`.
This will give you the path where ffmpeg is installed. For example, it might return `/usr/local/bin/youtube-dl`.

Check the [install instructions](https://github.com/rg3/youtube-dl#installation) if your don't have it installed



## Installation :

- Clone this repository
- Bundle install


## Usage :

  Usage: youtube-multiple-dl [options] [URL]
    -o, --output OUTPUT              Set output directory
    -s, --start                      Start downloading
    -w, --worker_number NUMBER       Number of paralell downloads
    -a, --add                        Add url to download
    -p, --priority PRIORITY          Set a priority for the download
    -d, --delete URL                 Delete url from queue
    -l, --list                       List urls in queue
    -i, --import FILE                Import batch file of url to dowload
    -h, --help                       Prints this help


