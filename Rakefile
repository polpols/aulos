require 'active_record'
require 'yaml'
require 'Logger'

Dir.glob("./models/*").each {|t| require t}


task :default => :migrate

desc "Migrate the database through scripts in db/migrate. Target specific version with VERSION=x"
task :migrate => :environment do
  ActiveRecord::Migrator.migrate('db/migrate', ENV["VERSION"] ? ENV["VERSION"].to_i : nil )
end

task :environment do
  ActiveRecord::Base.establish_connection(YAML::load(File.open('db/db.yml')))
  ActiveRecord::Base.logger = Logger.new(File.open('database.log', 'a'))
end

task :imslp do

end
