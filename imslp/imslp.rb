require "rubygems"
require "open-uri"
require "Nokogiri"

class Imslp
  attr_accessor :page
  def initialize(url)
    @page=Nokogiri::HTML(open(url))
    @root="http://imslp.org"
    @comps=File.new("comp3s.txt" ,"w")
  end
  
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

  def getComposersInPage(page)
    comps=[]
    css="#mw-subcategories * li a"
    page.css(css).each do |a| 
      #p a.text
#      @comps<< [a.text,@root+a.get_attribute("href")]
      @comps<< "#{a.text}|#{@root}#{a.get_attribute("href")}\n"
    end
    return comps
  end
  
  def getAllComposers(page="http://imslp.org/wiki/Category:Composers")
    page=Nokogiri::HTML(open(page))
   # @comps<<getComposersInPage(page)
    getComposersInPage(page)
    cond =getNextPage(page)
    if cond != "" 
      getAllComposers("#{@root}#{cond}")
    end
    return @comps
    @comps.close()
  end
  
  def getWorksInPage(page)
    works=[]
    css="#mw-subcategories * li a"
    page.css(css).each do |a| 
      #p a.text
      works<< [a.text,@root+a.get_attribute("href")] 
    end
    return works
    
  end
  
  def getAllWorks(composer)
    
  end
end


im=Imslp.new("http://imslp.org/wiki/Category:Composers")
p im.getAllComposers()
