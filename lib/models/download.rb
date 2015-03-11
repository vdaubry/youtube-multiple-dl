module YoutubeMultipleDL
  class Download
    attr_reader :priority, :url
    
    def initialize(url:, priority:nil)
      @url = url
      @priority = priority || 20
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
      system("youtube-dl --ignore-config -o ~/Downloads/'%(title)s.%(ext)s' #{@url}")
    end
    handle_asynchronously :call_downloader, :priority => Proc.new {|s| s.priority }
    
  end
end