require 'pry'
class CLI < Scraper
    def initialize
        self.call
    end
    def run
        puts "Hello, I heard you're spending sometime in New York City."
        puts "Save some money by going to one of the great free or low cost museums of NYC"
        start
    end
    def start
        puts "What weekday are you free?(ex.Monday)"
        weekdays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday","Saturday","Sunday"]
        @date = gets.chomp.downcase.capitalize
        if weekdays.include?(@date)  
            check_date
        else 
            puts "Please Try Again"
            start 
        end
        stage_two
    end
    def check_date
        @museums_of_day = Museum.all.find_all do |museum|
            museum.days.include?(@date) || museum.days.include?("Always free") 
        end
        @museums_of_day.each.with_index do |k,i|
            puts "#{i+1}. #{k.name}"
        end
        stage_two
     end
     def stage_two
        puts "Pick a number to learn more of a museum, or 0 to pick a different date"
        @answer = gets.chomp   
        if @answer == "0"
            start 
        elsif @answer.to_i > 0 && @answer.to_i <= @museums_of_day.size  
            second_page(@museums_of_day[@answer.to_i-1])
            bio
        else 
            puts "Please Try again"
            check_date
            stage_two
        end
     end

    def bio       
        if @museums_of_day[@answer.to_i-1].bio == "Information Error. Sorry we don't have info about the museum you selected"
            puts @museums_of_day[@answer.to_i-1].bio
            check_date           
        else puts @museums_of_day[@answer.to_i-1].bio
            puts "\nDo you like this museum and want to learn more/or pick a different museum(1/2)"
            
            answer = gets.chomp 
        end
        if answer == "1"
           puts "Open Hours: #{@museums_of_day[@answer.to_i-1].hours}"
           puts "Address: #{@museums_of_day[@answer.to_i-1].address}"
           puts " \n\n\n Do you want some directions?(y/n) "
           direction_choice
        elsif answer == "2"
            check_date
        else "Try Again"
            bio
        end
    end
    def direction_choice
        answer = gets.chomp
        if answer == "y" 
            puts "\n\n\n#{@museums_of_day[@answer.to_i-1].transport}\n\n\n\n"
            puts "Awesome, enjoy your trip!"
            abort("Have a great day!")
        elsif answer == "n" 
            start
        else 
            puts "Please Try again"
            direction
        end
    end
   
    def call
        scraper = Scraper.new
        scraper.first_page
        # scraper.second_page
    end

end
 