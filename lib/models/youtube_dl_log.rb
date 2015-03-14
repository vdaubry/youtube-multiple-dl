module YoutubeMultipleDL
  class YoutubeDLLog
    def initialize(log_file:)
      @log_file=log_file
    end
    
    def progress
      line = File.open(@log_file).to_a.last.split("[download]").last
      progress = line.match(/(\d+|\d+[.]\d+)%.*/)
      progress[0] if progress
    end
    
    def read
      @pid = fork do
        loop do
          sleep 1
          current_progress = progress()
          if current_progress
            yield(current_progress) 
          else 
            puts "waiting for download to start..."
          end
        end
      end
    end
    
    def stop
      Process.kill 9, @pid
      File.delete(@log_file)
    end
  end
end