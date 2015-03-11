require 'delayed_job_active_record'

module YoutubeMultipleDL
  class Queue
    def self.process(num_workers:)
      num_workers ||= 1
      pids=[]
      num_workers.times do
        pids << fork do
          system("rake jobs:work")
        end
      end
      pids.each {|pid| Process.wait(pid) }
    end
    
    def self.display_urls(type)
      Delayed::Job.send(type).ordered.all.map {|job| job.object.url}.each do |url|
        yield(url)
      end
    end
    
    def self.list
      display_urls(:current) do |url|
        puts "#{url} <= downloading"
      end
      
      display_urls(:queued) do |url|
        puts "#{url}"
      end
      
      display_urls(:failed) do |url|
        puts "#{url} <= failed"
      end
    end
    
    def self.delete(url)
      Delayed::Job.where("handler like '%#{url}%'").destroy_all
    end
    
    def self.import(file)
      File.open(file, "r").each_line do |url|
        YoutubeMultipleDL::Download.new(url: url, priority: 20).start
      end
    end
  end
end