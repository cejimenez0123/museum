
require 'nokogiri'
require 'open-uri'
require 'pry'
class Scraper

    def scrape
        base_url = "https://www.timeout.com"
        @html = open("#{base_url}#{@page}")
        @doc = Nokogiri::HTML(@html)
    end
    def museums
        scrape
        museums_info = @doc.search(".tiles").css("article")
        museums = @doc.css(".tiles .listCard .card-content")[0..-2]
    end
    def first_page
        @page = "/newyork/museums/free-museum-days-in-nyc"
        museums
        scrape
         museums.map do |museum|
            @hash =  {
                        name: museum.css("h3").text.strip,             
                        days: museum.css(".info-wrapper p:nth-child(2)").text.strip,
                        neighborhood: museum.css(".list_feature__tags .list_feature__tag_item").text.strip,  
                    }
                    
            Museum.new(@hash)
            end
    end
    def second_page
        museums.map do |museum|
            @page = museum.css(".buttons a")[0]['href']
            scrape
            hash = {bio: @doc.at_css("article p").text}
           
              end
    end
 
end