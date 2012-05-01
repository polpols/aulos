require 'rubygems'
require 'active_record'
require 'yaml'
require 'sqlite3'
require 'logger'
require 'nokogiri'

def init()
  dbconfig = YAML::load(File.open('db/uquebec.yml'))
  ActiveRecord::Base.establish_connection(dbconfig)
  ActiveRecord::Base.logger = Logger.new(File.open('database.log', 'a'))
  Dir.glob("./models/*").each{|m| require m}
end


def composers () 
  Dir.glob("./sources/www.uquebec.ca/musique/compo/*").each do |page|
    doc=Nokogiri::HTML(File.open(page))
    doc.css("center tr")[1..-1].each do |composer|
      c=Composer.new()
      c.name=composer.css("td")[0].text.split(",")[0]
      c.surname=composer.css("td")[0].text.split(",")[1]
      c.origin=composer.css("td")[3].text
      c.life=composer.css("td")[1].text
      c.save
    end
  end
end