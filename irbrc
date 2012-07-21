require 'irb/completion'
require 'irb/ext/save-history'

require 'rubygems'
require 'active_record'
require 'yaml'
require 'sqlite3'
require 'logger'
require 'nokogiri'
require 'open-uri'

dbconfig = YAML::load(File.open('db/imslp.yml'))
ActiveRecord::Base.establish_connection(dbconfig)
ActiveRecord::Base.logger = Logger.new(File.open('database.log', 'a'))


Dir.glob("./models/*").each do |m|
  require m
end

Dir.glob("./helpers/im*").each do |m|
  require m
end

ARGV.concat [ "--readline",
              "--prompt-mode",
              "simple" ]


IRB.conf[:SAVE_HISTORY] = 100
IRB.conf[:HISTORY_FILE] = "./irb-history.rb"