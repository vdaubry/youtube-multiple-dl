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
    def initialize(text:)
      @text = text ||= ""
    end
    
    def content(size:)
      text = if @text.length < size
        number_of_spaces = size-@text.length
        @text+" "*number_of_spaces
      else
        @text[0..size-4]+"..."
      end
      text.gsub("\n",' ')
    end
  end
  
  
  class TableOutput::Row
    def column_sizes
      [5, 45, 20, 50]
    end
    
    def content(columns:)
      columns.each_with_index.map {|column, index| column.content(size: column_sizes[index])}.join(" | ")+" | "
    end
  end
  
  class TableOutput::HeaderRow < TableOutput::Row
    def content
      columns = []
      columns << TableOutput::Column.new(text: "ID")
      columns << TableOutput::Column.new(text: "URL")
      columns << TableOutput::Column.new(text: "STATUS")
      columns << TableOutput::Column.new(text: "INFOS")
      super(columns: columns)
    end
  end
  
  
  class TableOutput::JobRow < TableOutput::Row
    def initialize(job:)
      @job = job
    end
    
    def content
      columns = []
      columns << TableOutput::Column.new(text: @job.id.to_s)
      columns << TableOutput::Column.new(text: @job.object.url)
      columns << TableOutput::Column.new(text: status)
      columns << TableOutput::Column.new(text: info)
      super(columns: columns)
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