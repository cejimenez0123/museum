require_relative '../config/enviroment.rb'
require_relative '../lib/scraper.rb'
class Museum
  attr_accessor  :name , :days , :neighborhood, :link, :bio
  @@all = []
  
  def initialize(hash)
   @name = hash[:name]
    @days = hash[:days]
    @neighborhood = hash[:neighborhood]
   @@all << self
  end
  def self.all
    @@all
  end
  
end
