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
      if input.to_i > 0 && input.to_i <= category.topics.count
          sections_menu(category.topics[input.to_i - 1])
      elsif input == "next"
          display_index = list_topics(category, display_index)
      elsif input == "cat"
        list_categories
        categories_menu
        input = "exit"
      end
    end
  end

  def sections_menu(topic)
    puts "Enter the number of the method you'd like to learn about."
    topic.sections.each.with_index(1) {|section, i|puts "#{i}. #{section[:section_title]}"}
    input = gets.strip.downcase
    if input.to_i > 0 && input.to_i <= topic.sections.count
      display_section(topic.sections[input.to_i - 1])
    end
  end

  def display_section(section)
    section[:section_steps].each.with_index(1) do |step_description, step_number|
      display_step(step_description, step_number)
    end
  end

  def display_step(step_description, step_number)
    step_description.each do |layer_1|
      (layer_1.is_a? Array) ? display_first_layer_list(layer_1) : puts("\n#{step_number}. #{layer_1}")
    end
  end

  def display_first_layer_list(layer_1)
    layer_1.each do |layer_2|
      (layer_2.is_a? Array) ? display_second_layer_list(layer_2) : puts("\n\e[#{31}m#{self}\e[0m #{layer_2}\n")
    end
  end

  def display_second_layer_list(layer_2)

  end

  def good_bye
    puts "Goodbye!"
  end
end
