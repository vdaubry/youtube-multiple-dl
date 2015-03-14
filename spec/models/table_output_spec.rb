require 'spec_helper'

describe YoutubeMultipleDL::TableOutput do
  
  describe "column" do
    context "text smaller than column size" do
      it "displays text with spaces" do
        YoutubeMultipleDL::TableOutput::Column.new(text: "abc", size: 10).content.should == "abc       "
      end
    end  
    
    context "text is nil" do
      it { YoutubeMultipleDL::TableOutput::Column.new(text: nil, size: 10).content.should == "          " }
    end
    
    context "text is larger than column size" do
      it { YoutubeMultipleDL::TableOutput::Column.new(text: "a"*11, size: 10).content.should == "aaaaaaa..." }
    end
    
    context "text has special chars" do
      it { YoutubeMultipleDL::TableOutput::Column.new(text: " \n chars", size: 10).content.should == "   chars  " }
    end
  end
  
  describe "row" do
    before(:each) do
      YoutubeMultipleDL::TableOutput::Row.any_instance.stubs(:column_sizes).returns([10, 15, 10])
      YoutubeMultipleDL::Download.new(url: "http://www.foo.bar", priority: 1).call_downloader
      @job = Delayed::Job.last
    end
    
    it "displays header" do
      YoutubeMultipleDL::TableOutput::HeaderRow.new.content.should == "URL        | STATUS          | INFOS      | "
    end
    
    it "displays queued jobs" do
      res = YoutubeMultipleDL::TableOutput::JobRowQueued.new(job: @job).content.should == "http://... | queued          |            | "
    end
    
    it "displays downloading jobs" do
      @job.update_attributes(progress_info: "foobar")
      res = YoutubeMultipleDL::TableOutput::JobRowCurrent.new(job: @job).content.should == "http://... | downloading     | foobar     | "
    end
    
    it "displays failed jobs" do
      @job.update_attributes(last_error: "error")
      res = YoutubeMultipleDL::TableOutput::JobRowFailed.new(job: @job).content.should == "http://... | failed          | error      | "
    end
    
  end
  
end