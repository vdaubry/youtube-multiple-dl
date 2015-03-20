require 'open3'

module YoutubeMultipleDL
  class Download
    attr_reader :priority, :url
    
    def initialize(url:, priority:nil, output:nil)
      @url = url
      @priority = priority || 20
      @output = output || "/media/HDD/ftp/vids/new/download"
    end
    
    def start
      url = YoutubeMultipleDL::URL.new(url: @url)
      
      if !url.valid?
        puts "'#{url.to_s}' is not a valid url"
        exit
      end
      
      call_downloader
    end
    
    def call_downloader
      log_file = "log/log-#{Process.pid}.log"
      log = YoutubeMultipleDL::YoutubeDLLog.new(log_file: log_file)
      j = Delayed::Job
          .current
          .with_url(@url)
          .first
      
      log.read do |progress|
        puts progress
        begin
          j.update_attributes(:progress_info => progress)
        rescue StandardError => e
          puts "SQLite table is locked, will try to update progress next cycle"
          sleep rand(4)+1 #sleep random value so that process do not retry all at the same time
        end
      end
      
      cmd = "youtube-dl --ignore-config -o #{@output}'%(title)s.%(ext)s' #{@url}"
      success = system("#{cmd.gsub("\n",' ')} >> #{log_file} 2>&1")
      log.stop
      raise "download failed" unless success
    end
    handle_asynchronously :call_downloader, :priority => Proc.new {|s| s.priority }
  end
end