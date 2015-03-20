require 'optparse'
require 'singleton'
require 'byebug'

module YoutubeMultipleDL
  class CLI
    include Singleton
    
    def run(args)
      params, url_param = parse_cli_args(args)
      
      if params.has_key?(:start)
        YoutubeMultipleDL::Queue.process(num_workers: params[:workers].to_i)
      elsif params.has_key?(:add)
        YoutubeMultipleDL::Download.new(url: url_param.first, priority: params[:priority], output: params[:output]).start
      elsif params.has_key?(:list)
        YoutubeMultipleDL::Queue.list
      elsif params.has_key?(:to_delete)
        YoutubeMultipleDL::Queue.delete(params[:to_delete])
      elsif params.has_key?(:file)
        YoutubeMultipleDL::Queue.import(params[:file])
      elsif params.has_key?(:clear)
        YoutubeMultipleDL::Queue.delete_all
      end
    end
    
    def parse_cli_args(argv)
      
      options = {}
      opt_parser = OptionParser.new
      opt_parser.banner = "Usage: youtube-multiple-dl [options] [URL]"
      options[:workers]=1
      options[:priority]=20
      options[:output]="/media/HDD/ftp/vids/new/download/"
      
      opt_parser.on("-o", "--output OUTPUT", "Set output directory") do |o|
        options[:output] = o
      end
      
      opt_parser.on("-s", "--start", "Start downloading") do
        options[:start] = true
      end
      
      opt_parser.on("-w", "--worker_number NUMBER", "Number of paralell downloads") do |w|
        options[:workers] = w
      end
      
      opt_parser.on("-a", "--add", "Add url to download") do
        options[:add] = true
      end
      
      opt_parser.on("-p", "--priority PRIORITY", "Set a priority for the download") do |p|
        options[:priority] = p
      end
      
      opt_parser.on("-d", "--delete URL", "Delete url from queue") do |url|
        options[:to_delete] = url
      end
      
      opt_parser.on("-c", "--clear", "delete all urls") do |file|
        options[:clear] = true
      end
      
      opt_parser.on("-l", "--list", "List urls in queue") do
        options[:list] = true
      end
      
      opt_parser.on("-i", "--import FILE", "Import batch file of url to dowload") do |file|
        options[:file] = file
      end
        
      opt_parser.on("-h", "--help", "Prints this help") do
        puts opt_parser
        exit
      end
      
      url = opt_parser.parse!(argv)
      
      return options, url
    end
  end
end