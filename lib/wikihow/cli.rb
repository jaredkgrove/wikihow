#CLI Controller
class Wikihow::CLI

  def call
    puts "Welcome to Wikihow"
    list_categories
    categories_menu
    good_bye
  end

  def list_categories
    #get categories
    @categories = Wikihow::Category.get_or_create_categories
    @categories.each.with_index(1) {|category, i| puts "#{i}. #{category.title}"}
  end

  def categories_menu
    input = nil
    while input != "exit"
      puts "Enter the number of the category that you'd like to learn about. Type 'list' to display categories. Type 'exit' to close."
      input = gets.strip.downcase
      if input.to_i > 0 && input.to_i <= @categories.count
        category = @categories[input.to_i - 1]
        list_topics(category)
        topics_menu(category)
        input = "exit"
      elsif input == "list"
        list_categories
      else
        puts "Please enter a valid command."
      end
    end
  end

  def list_topics(category, start_index = 0)
    @topics = Wikihow::Topic.get_or_create_topics_from_category(category)
    if start_index < (@topics.count - 1)
      @topics[start_index..start_index + 9].each.with_index(start_index + 1) {|topic, i| puts "#{i}. #{topic.title}"}
      start_index + 9
    else
      puts "Those are all the topics for this category. Would you like to start from the top of the list? Y/N"
      input = gets.strip.downcase
      start_index = list_topics(category) if input =="y"
    end
  end

  def topics_menu(category)
    input = nil
    display_index = 9
    while input != "exit"
      puts "Enter the number of the topic that you'd like to learn how to do. Type 'next' to display the next 10 topics. Type 'cat' to return to categories menu. Type 'exit' to quit."
      input = gets.strip.downcase
      if input.to_i > 0 && input.to_i <= @topics.count
          dislplay_topic(@topics[input.to_i - 1])
      elsif input == "next"
          display_index = list_topics(category, display_index)
      elsif input == "cat"
        list_categories
        categories_menu
        input = "exit"
      end
    end
  end

  def dislplay_topic(topic)

    puts topic.steps
  end

  def good_bye
    puts "Goodbye!"
  end
end
