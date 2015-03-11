require 'uri'

module YoutubeMultipleDL
  class URL
    def initialize(url:)
      @url = url
    end
      
    def valid?
      @url =~ URI::regexp
    end
    
    def to_s
      @url
    end
  end
end