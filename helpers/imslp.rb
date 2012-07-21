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

@root="http://imslp.org"
@composer_list_css="#mw-subcategories * li a"
@life_date_css="cp_firsth"
@img_css=".cp_img"
@next_page_css="div[style='text-align:center;font-size:150%;font-weight:bold'] a"


# Compositeurs 

# Main loop.
def getAllComposers(page="http://imslp.org/wiki/Category:Composers")
  page=Nokogiri::HTML(open(page))
  getComposersInPage(page)
  cond =getNextPage(page)
  if cond != "" 
    getAllComposers("#{@root}#{cond}")
  end
end

# Grab composers name surname link in a given page.
def getComposersInPage(page)
  page.css(@composer_list_css).each do |line| 
    url=@root+line.get_attribute("href")
    comp_data=Nokogiri::HTML(open(url))
    life=/\(.*\)/.match(comp_data.css(@life_date_css).text).to_s if comp_data.css(@life_date_css).text!=""
    pict=comp_data.css(@img_css).get_attribute("href") if comp_data.css(@img_css).text!=""
    Composer.new(
    :name=>line.text.split(",")[0],
    :surname=>line.text.split(",")[1],
    :url=>url,
    :life=>life 
    )
  end
end

# Finds the << Next 200 >> button in a page and retrieves url if it has one.
def getNextPage(page)
  url=""
  page.css(@next_page_css).each do |t| 
    if t.text=="next 200" 
      url=t.get_attribute("href")
      end
  end
  return url
end

def getWorksInPage(page)
   works=[]
   css="#mw-subcategories * li a"
   page.css(css).each do |a| 
     works<< [a.text,@root+a.get_attribute("href")] 
   end
   return works    
 end
 
 def getAllWorks(composer)
   
 end