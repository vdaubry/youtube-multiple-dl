module YoutubeMultipleDL
  class TableOutput
    def jobs(type:)
      Delayed::Job.send(type).ordered
    end
    
    def display
      puts TableOutput::HeaderRow.new.content
      jobs(type: :current).each {|j| puts TableOutput::JobRowCurrent.new(job: j).content }
      jobs(type: :queued).each {|j| puts TableOutput::JobRowQueued.new(job: j).content }
      jobs(type: :failed).each {|j| puts TableOutput::JobRowFailed.new(job: j).content }
    end
  end
  
  
  class TableOutput::Column
    def initialize(text:, size:)
      @text = text ||= ""
      @size = size
    end
    
    def content
      text = if @text.length < @size
        number_of_spaces = @size-@text.length
        @text+" "*number_of_spaces
      else
        @text[0..@size-4]+"..."
      end
      text.gsub("\n",' ')
    end
  end
  
  
  class TableOutput::Row
    def column_sizes
      [45, 20, 50]
    end
  end
  
  class TableOutput::HeaderRow < TableOutput::Row
    def content
      column1 = TableOutput::Column.new(text: "URL", size: column_sizes[0])
      column2 = TableOutput::Column.new(text: "STATUS", size: column_sizes[1])
      column3 = TableOutput::Column.new(text: "INFOS", size: column_sizes[2])
      column1.content+" | "+column2.content+" | "+column3.content+" | "
    end
  end
  
  
  class TableOutput::JobRow < TableOutput::Row
    def initialize(job:)
      @job = job
    end
    
    def content
      column1 = TableOutput::Column.new(text: @job.object.url, size: column_sizes[0])
      column2 = TableOutput::Column.new(text: status, size: column_sizes[1])
      column3 = TableOutput::Column.new(text: info, size: column_sizes[2])
      column1.content+" | "+column2.content+" | "+column3.content+" | "
    end
  end
  
  class TableOutput::JobRowCurrent < TableOutput::JobRow
    def info
      @job.progress_info
    end
    
    def status
      "downloading"
    end
  end
  
  class TableOutput::JobRowQueued < TableOutput::JobRow
    def info
      nil
    end
    
    def status
      "queued"
    end
  end
  
  class TableOutput::JobRowFailed < TableOutput::JobRow
    def info
      @job.last_error
    end
    
    def status
      "failed"
    end
  end
  
end