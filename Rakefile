$:.unshift File.dirname(__FILE__)
require 'bundler'
require 'delayed/tasks'
require 'lib/youtube_multiple_dl'

namespace :jobs do
  task :environment do
    Database.connect
  end
end
 
namespace :db do
  
  desc 'Migrate the database'
  task :migrate do
    Database.migrate
  end
  
  desc 'Rollback previous migration'
  task :rollback do
    Database.rollback
  end
 
  desc 'Drop database'
  task :drop do
    Database.drop
  end
 
end