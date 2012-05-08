require "rubygems"
require "open-uri"
require "nokogiri"

Dir.glob("../models/*").each do |m|
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
  #return @comps
  #@comps.close()
end

# Grab composers name surname link in a given page.
def getComposersInPage(page)
  comps=[]
  css="#mw-subcategories * li a"
  page.css(css).each do |line| 
    url=@root+line.get_attribute("href")
    new_data=Nokogiri::HTML(open(url))
    life=/\(.*\)/.match(new_data.css("div.cp_firsth").text).to_s if new_data.css("div.cp_firsth").text!=""
    pict=new_data.css(".cp_img a").get_attribute("href") if new_data.css(".cp_img").text!=""
    Composer.new(
    :name=>line.text.split(",")[0],
    :surname=>line.text.split(",")[1],
    :url=>url,
    :life=>life 
    )
  end
  return comps
end

# Finds the << Next 200 >> button in a page and retrieves url if it has one.
def getNextPage(page)
  css="div[style='text-align:center;font-size:150%;font-weight:bold'] a"
  url=""
  page.css(css).each do |t| 
    if t.text=="next 200" 
      url=t.get_attribute("href")
      end
  end
  return url
end

 
def getComposer(line)
  return [line.text.split(",")[0],line.text.split(",")[1],root+a.get_attribute("href")]
  
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