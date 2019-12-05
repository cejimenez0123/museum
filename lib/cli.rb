class CLI
    def run
        puts "Hello, I heard you're spending sometime in New York City."
        puts "Save some money by going to one of the great free or low cost museums of NYC"
        start
    end
    def start
        puts "What weekday are you free?(ex.Monday)"
        self.call
        @date = gets.chomp.downcase.capitalize
        case @date
            when "Monday"
                check_date
            when "Tuesday"
                check_date
            when "Wednesday"
                check_date
            when "Thursday"
                check_date
            when "Friday"
                check_date
            when "Sunday"
                check_date
            when "Saturday"
                check_date
            else "Try again"
        end
        stage_two
    end
    def check_date

        @museums = Museum.all.find_all do |museum|
         museum.days.include?(@date) || museum.days== "Always free" 
             end
        @museums.each.with_index do |k,i|
            puts "#{i+1}. #{k.name}"
        end
     end
     def stage_two
        puts "Do you want to learn more of a museum? Pick a number or Pick a different date"
         @answer = gets.chomp
         if @answer.is_i? 
            bio
         else @date = @answer
            check_date
         end
     end
     def bio
        @museums.each.with_index do |k,i|
            @answer.to_i == i+1
            k.bio
        end 

     end
     def is_i?
        !!(@answer =~ /\A[-+]?[0-9]+\z/)
     end
    def call
        scraper = Scraper.new
        scraper.first_page
        scraper.second_page
    end

end
 