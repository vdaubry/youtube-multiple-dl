module YoutubeMultipleDL
  class Delayed::Job
    def self.ordered
      order("priority ASC")
    end
    
    def self.current
      where("locked_at IS NOT NULL AND failed_at IS NULL")
    end
    
    def self.failed
      where("failed_at IS NOT NULL")
    end
    
    def self.queued
      where("locked_at IS NULL AND failed_at IS NULL")
    end
    
    def object
      YAML.load(self.handler).object
    end
  end
end