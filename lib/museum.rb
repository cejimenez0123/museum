require_relative '../config/enviroment.rb'
class Museum
  attr_accessor  :name , :days , :neighborhood, :url, :bio, :hours, :address, :transport
  @@all = []  
  def initialize(hash)
   @name = hash[:name]
    @days = hash[:days]
    @neighborhood = hash[:neighborhood]
    @url = hash[:url]
   @@all << self
  end
  def self.all
    @@all
  end  
end
