require 'active_record'
require 'bundler'
require 'delayed/tasks'
require 'delayed_job_active_record'
require_relative 'db/database'

path = File.expand_path('initializers', File.dirname(__FILE__))
Dir[path+"/**/*.rb"].each {|file| require file}

path = File.expand_path('models', File.dirname(__FILE__))
Dir[path+"/**/*.rb"].each {|file| require file}

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