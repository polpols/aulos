require 'rubygem'
require "open-uri"
require "nokogiri"

# ----> URL
MainUrl='http://www.henry-lemoine.com/fr/catalogue/rechercheResultat.html'
SearchUrl="http://www.henry-lemoine.com/fr/catalogue/rechercheResultat.html?page="

# ----> CSS

nbr_lignes=".r1 b"
row="table.liste"
row_url="div.liste-produit a"

# ----> INIT

@doc=""
@nbr_lines=""


def conf
  dbconfig = YAML::load(File.open('db.yml'))
  ActiveRecord::Base.establish_connection(dbconfig)
  ActiveRecord::Base.logger = Logger.new(File.open('database.log', 'a'))
end

def get_nbr_pages
  doc=NOKOGIRI::HTML(open(MainUrl))
  return doc.css(nbr_pages).text.to_i/20+1  
 end

def get_url (fragment)
  return fragment.css(row_url).attribute('href').text
end

def get_item(url)
  
end

def main
  conf()
  (1..get_nbr_pages()).each do |page|
    doc=Nokogiri::HTML(open("#{SearchUrl}#{page}"))
    doc.css(row).each do |r|
      url=r.css(row_url).attribute('href')
      
    end
  end
end