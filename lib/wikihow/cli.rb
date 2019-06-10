#CLI Controller
class Wikihow::CLI
  def call
    puts "Welcome to Wikihow"
    list_categories
    menu
    good_bye
  end

  def list_categories
    #get categories

    @categories = Wikihow::Category.display
  end

  def menu

    input = nil
    while input != "exit"
      puts "Enter the number of the category that you'd like to learn about. Type 'list' to display categories. Type 'exit' to close."
      input = gets.strip.downcase
      case input
      when "1"
        puts "more info on category 1"
      when "2"
        puts "more info on category 2"
      when "3"
        puts "more info on category 3"
      when "list"
        list_categories
      else
        puts "Please enter a valid command."
      end
    end
  end

  def good_bye
    puts "Goodbye!"
  end
end
