require "rubygems"
require "open-uri"
require "nokogiri"


# Compositeurs 

root="http://imslp.org"

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
  page.css(css).each do |a| 
    comps<<getComposer(a)
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