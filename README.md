# youtube-multiple-dl

Multiple downloads in parralel for youtube-dl


youtube-multiple-dl
===================


This project is a lightweight job queue around youtube-dl. It provides command line interface to : 

1 - Start multiple process to downloads multiple url content in parallel with youtube-dl
2 - Manage the queue : add URL to the queue, delete, list job progress, etc


Screenshot
----

![](https://github.com/vdaubry/youtube-multiple-dl/blob/master/screenshot.jpg)



## Benefit :

There are several benefit to using a job queue instead of a text file to store URLs to downloads :

- Retries : In case a download fails it will be automatically retried
- Priority : you can order the importance of downloads by setting a priority level to the URL you add to the queue
- Concurrency : Easily downloads multiple files in parallel by adding more worker process


## Requirements :

[youtube-dl](https://github.com/rg3/youtube-dl) must be installed. To ensure it is available, on your command line, run `which youtube-dl`.
This will give you the path where ffmpeg is installed. For example, it might return `/usr/local/bin/youtube-dl`.

Check the [install instructions](https://github.com/rg3/youtube-dl#installation) if your don't have it installed



## Installation :

- Clone this repository
- Bundle install


## Usage :

First start some download worker, for example if you want to download 3 files at the same time :

  youtube-multiple-dl --start --worker_number 3
  

Then add some url to the queue :

  youtube-multiple-dl -add https://www.youtube.com/watch?v=Y7RnH6bnGHc


For more information see help :

  Usage: youtube-multiple-dl [options] [URL]
    -o, --output OUTPUT              Set output directory
    -s, --start                      Start downloading
    -w, --worker_number NUMBER       Number of paralell downloads
    -a, --add                        Add url to download
    -p, --priority PRIORITY          Set a priority for the download
    -d, --delete URL                 Delete url from queue
    -c, --clear                      delete all urls
    -l, --list                       List urls in queue
    -i, --import FILE                Import batch file of url to dowload
    -h, --help                       Prints this help