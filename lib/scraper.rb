
require 'nokogiri'
require 'open-uri'
require 'pry'
class Scraper
    def scrape
        base_url = "https://www.timeout.com"
        html = open("#{base_url}#{@page}")
        @doc = Nokogiri::HTML(html)
    end
    def museums
        museums_info = @doc.search(".tiles").css("article")
        @node_elements = @doc.css(".tiles .listCard .card-content")[0..-2]
    end
    def first_page
        @page = "/newyork/museums/free-museum-days-in-nyc"
        scrape
        museums
        @node_elements.map do |node|
            hash =  {
                        name: node.css("h3").text.strip,             
                        days: node.css(".info-wrapper p:nth-child(2)").text.strip,
                        neighborhood: node.css(".list_feature__tags .list_feature__tag_item").text.strip,  
                        url: node.css(".buttons a")[0]['href']
                    }
            Museum.new(hash)
        end
    end
    def second_page(museo)
        @page = museo.url 
        scrape
        bio_node_element = @doc.css('.sm-pt1.sm-pb1')
        details_node = @doc.css('.listing_details')
        museo.hours = details_node.css('td').css('td.xs-px0').children[-4].text.strip if details_node.css('td').css('td.xs-px0').children[-4]
        museo.address = details_node.css('td').children[0].text.strip if details_node.css('td').children[0]
        museo.transport = details_node.css('td').children[8].text if details_node.css('td').children[8]
        if !details_node.css('td').children[0]
            museo.bio = "Information Error. Sorry we don't have info about the museum you selected"
        elsif bio_node_element.css('div [itemprop^="reviewBody"]')  
            museo.bio = bio_node_element.css('div [itemprop^="reviewBody"]').text
        else
            museo.bio = "Information Error. Sorry we don't have info about the museum you selected"
        end
    end
end