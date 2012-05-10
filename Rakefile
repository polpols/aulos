require 'rubygems'
require 'active_record'
require 'yaml'
require 'logger'

Dir.glob("./models/*").each {|t| require t}


task :default => :migrate

desc "Migrate the database through scripts in db/migrate. Target specific version with VERSION=x"
task :migrate => :environment do
  ActiveRecord::Migrator.migrate('db/migrate', ENV["VERSION"] ? ENV["VERSION"].to_i : nil )
end

task :environment do
  ActiveRecord::Base.establish_connection(YAML::load(File.open('db/uquebec.yml')))
  ActiveRecord::Base.logger = Logger.new(File.open('database.log', 'a'))
end

task :imslp do
  ActiveRecord::Base.establish_connection(YAML::load(File.open('db/imslp.yml')))
  ActiveRecord::Base.logger = Logger.new(File.open('database.log', 'a'))
  ActiveRecord::Migrator.migrate('db/migrate', ENV["VERSION"] ? ENV["VERSION"].to_i : nil )
end
