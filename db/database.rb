require 'yaml'
require 'logger'
require 'active_record'

class Database
  
  def self.migrate
    connect
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.migrate "db/migrations"
  end
  
  def self.drop
    connect
    File.delete(config["database"])
  end
  
  def self.rollback
    connect
    ActiveRecord::Migrator.rollback "db/migrations"
  end
  
  def self.connect
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    ActiveRecord::Base.logger.level = Logger::INFO
    ActiveRecord::Base.establish_connection(config)
  end
  
  private
  
  def self.config
    YAML::load(File.open('config/database.yml'))[ENV["environment"]]
  end
end