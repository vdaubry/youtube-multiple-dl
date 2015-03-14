require 'spec_helper'

describe YoutubeMultipleDL::YoutubeDLLog do
  describe "progress" do
    context "new download" do
      it "returns latest progress" do
        log = YoutubeMultipleDL::YoutubeDLLog.new(log_file: "spec/fixtures/log-19473.log")
        log.progress.should == "7.8% of 962.77MiB at 811.34KiB/s ETA 18:39"
      end
    end
    
    context "already downloaded" do
      it "returns latest progress" do
        log = YoutubeMultipleDL::YoutubeDLLog.new(log_file: "spec/fixtures/log-19928.log")
        log.progress.should == "100% of 24.56MiB"
      end
    end
    
    it "returns latest progress" do
      log = YoutubeMultipleDL::YoutubeDLLog.new(log_file: "spec/fixtures/log-19474.log")
      log.progress.should == nil
    end
  end
end