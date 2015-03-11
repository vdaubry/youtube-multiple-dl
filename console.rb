require 'irb'
require 'delayed_job_active_record'
require_relative 'db/database'
path = File.expand_path('models', File.dirname(__FILE__))
Dir[path+"/**/*.rb"].each {|file| require file}

path = File.expand_path('initializers', File.dirname(__FILE__))
Dir[path+"/**/*.rb"].each {|file| require file}

path = File.expand_path('extensions', File.dirname(__FILE__))
Dir[path+"/**/*.rb"].each {|file| require file}

Database.connect

module IRB
  def self.start_session(binding)
    unless @__initialized
      args = ARGV
      ARGV.replace(ARGV.dup)
      IRB.setup(nil)
      ARGV.replace(args)
      @__initialized = true
    end

    workspace = WorkSpace.new(binding)

    irb = Irb.new(workspace)

    @CONF[:IRB_RC].call(irb.context) if @CONF[:IRB_RC]
    @CONF[:MAIN_CONTEXT] = irb.context

    catch(:IRB_EXIT) do
      irb.eval_input
    end
  end
end

IRB.start_session(binding)
