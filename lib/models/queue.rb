module YoutubeMultipleDL
  class Queue
    def self.process(num_workers:)
      num_workers ||= 1
      pids=[]
      exception = false
      num_workers.times do
        pids << fork do
          system("rake jobs:work")
        end
      end
      pids.each {|pid| Process.wait(pid) }
    end
    
    def self.list
      YoutubeMultipleDL::TableOutput.new.display
    end
    
    def self.delete(url)
      Delayed::Job.with_url(url).destroy_all
    end
    
    def self.delete_all
      Delayed::Job.destroy_all
    end
    
    def self.import(file)
      File.open(file, "r").each_line do |url|
        YoutubeMultipleDL::Download.new(url: url, priority: 20).start
      end
    end
  end
end