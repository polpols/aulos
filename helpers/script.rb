require 'rubygems'
require 'active_record'
require 'yaml'
require 'sqlite3'
require 'logger'

dbconfig = YAML::load(File.open('db/db.yml'))
ActiveRecord::Base.establish_connection(dbconfig)
ActiveRecord::Base.logger = Logger.new(File.open('database.log', 'a'))

Dir.glob("./models/*").each {|t| require t}


im=Imslp.new("http://imslp.org/wiki/Category:Composers")
p im.getAllComposers()
