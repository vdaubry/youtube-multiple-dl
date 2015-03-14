require 'spec_helper'

describe Delayed::Job do
  before(:each) do
    @j1 = YoutubeMultipleDL::Download.new(url: "http://www.foo.bar", priority: 1).call_downloader
    @j2 = YoutubeMultipleDL::Download.new(url: "http://www.foo.bar", priority: 3).call_downloader
    @j3 = YoutubeMultipleDL::Download.new(url: "http://www.foo.bar", priority: 2).call_downloader
  end
  
  describe "ordered" do
    it "returns jobs ordered by priority" do
      Delayed::Job.ordered.should == [@j1, @j3, @j2]
    end
  end
  
  describe "current" do
    it "returns running jobs" do
      running = YoutubeMultipleDL::Download.new(url: "http://www.foo.bar", priority: 1).call_downloader
      running.update_attributes(:locked_at => DateTime.now)
      Delayed::Job.current.should == [running]
    end
  end
  
  describe "failed" do
    it "returns failed jobs" do
      failed = YoutubeMultipleDL::Download.new(url: "http://www.foo.bar", priority: 1).call_downloader
      failed.update_attributes(:last_error => "exception")
      Delayed::Job.failed.should == [failed]
    end
  end
  
  describe "queued" do
    it "returns failed jobs" do
      Delayed::Job.queued.should == [@j1, @j2, @j3]
    end
  end
  
  describe "with_url" do
    it "returns jobs with url" do
      Delayed::Job.with_url("http://www.foo.bar").should == [@j1, @j2, @j3]
    end
  end
  
end