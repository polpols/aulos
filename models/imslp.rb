require "rubygems"
require "open-uri"
require "nokogiri"

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
      getComposer(a)
      #@comps<< "#{a.text}|#{@root}#{a.get_attribute("href")}\n"
    end
    return comps
  end
  def getComposer(line)
    return [a.text.split(","),a.get_attribute("href"),a.root]
    
  end
  def getAllComposers(page="http://imslp.org/wiki/Category:Composers")
    page=Nokogiri::HTML(open(page))
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
      works<< [a.text,@root+a.get_attribute("href")] 
    end
    return works
    
  end
  
  def getAllWorks(composer)
    
  end
end

