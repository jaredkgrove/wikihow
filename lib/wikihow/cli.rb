#CLI Controller
class Wikihow::CLI
  @category
  def call
    puts "Welcome to Wikihow"
    list_categories
    menu
    good_bye
  end

  def list_categories
    #get categories
    @categories = Wikihow::Category.display
    @categories.each.with_index(1) {|category, i| puts "#{i}. #{category.name}"}
  end

  def menu

    input = nil
    while input != "exit"
      puts "Enter the number of the category that you'd like to learn about. Type 'list' to display categories. Type 'exit' to close."
      input = gets.strip.downcase
      if input.to_i > 0
        puts @categories[input.to_i - 1].name
      elsif input == "list"
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
