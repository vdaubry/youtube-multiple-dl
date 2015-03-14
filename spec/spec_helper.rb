$:.unshift File.expand_path("../../", __FILE__)
require 'lib/youtube_multiple_dl'

ENV["environment"]="test"
Database.connect

RSpec.configure do |config|
  config.mock_with :mocha
  config.expect_with(:rspec) { |c| c.syntax = :should }
  config.order = 'random'
  
  config.after(:each) do
    Delayed::Job.destroy_all
  end

end
