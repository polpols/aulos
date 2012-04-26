require 'rubygems'
require 'active_record'
require 'yaml'
require 'sqlite3'
require 'Logger'

dbconfig = YAML::load(File.open('db/db.yml'))
ActiveRecord::Base.establish_connection(dbconfig)
ActiveRecord::Base.logger = Logger.new(File.open('database.log', 'a'))

Dir.glob("./models/*").each {|t| require t}