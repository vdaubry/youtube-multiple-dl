youtube-multiple-dl
===================

This project adds support for multiple files downloading with youtube-dl.
[youtube-dl](https://github.com/rg3/youtube-dl) is a command line utility to download files from major streaming website (youtube, etc). At the moment you can only download files one at a time with youtube-dl. 

youtube-multiple-dl is a lightweight job queue around youtube-dl for parallel downloads, it provides a command line interface to : 

1. Start multiple download workers
2. Manage the queue : add URL to download, delete, list downloads progress, etc


## Screenshot

![](https://github.com/vdaubry/youtube-multiple-dl/blob/master/screenshot.jpg)


## Benefit :

There are several benefits to using a job queue over a text file to manage URLs to downloads :

- Retries : In case a download fails it will be automatically retried
- Priority : you can set order of downloads by setting a priority level to a URL
- Concurrency : Easily downloads multiple files in parallel by adding more worker process


## Requirements :

[youtube-dl](https://github.com/rg3/youtube-dl) must be installed.
To ensure it is available, on your command line, run `which youtube-dl`.
For example, it might return `/usr/local/bin/youtube-dl`.

If youtube-dl is not installed, check the [youtube-dl install instructions](https://github.com/rg3/youtube-dl#installation)


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
      
      
## How many downloads can i start ?

There is no hard limit to the number of worker you can start. However, this project uses SQLite for the job queue. SQLite can handle [some concurrency](http://www.sqlite.org/lockingv3.html), but you should not start more than a few workers process (< 5)

## Why SQLite ?

To avoid dependency to a heavier database (Postgres, Redis, etc). Since this project is primarily designed to be used on a personal computer we can't expect to have any database running.


## Contributing :

* Fork it `https://github.com/vdaubry/youtube-multiple-dl/fork`
* Create your feature branch `git checkout -b my-new-feature`
* Commit your changes `git commit -am 'Add some feature'`
* Push to the branch `git push origin my-new-feature`
* Create a new Pull Request

## License 

This project is available under the MIT license. [See the license file](LICENSE.md) for more details.
