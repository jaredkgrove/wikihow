#CLI Controller
class Wikihow::CLI
  @@red = 31
  @@green = 32
  @@yellow = 33
  @@blue = 34

  def call
    puts "Welcome to Wikihow"
    list_categories
    categories_menu
    good_bye
  end

  def list_categories
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
        display_index = list_topics(category)
        topics_menu(category, display_index)
        input = "exit"
      elsif input == "list"
        list_categories
      else
        puts "Please enter a valid command."
      end
    end
  end

  def list_topics(category, display_index = 0)
    @topics = Wikihow::Topic.get_or_create_topics_from_category(category)
    if display_index < (@topics.count - 1)
      @topics[display_index..display_index + 9].each.with_index(display_index + 1) {|topic, i| puts "#{i}. #{topic.title}"}
      display_index + 10
    else
      puts "Those are all the topics for this category. Here are the first ten topic for the category."
      list_topics(category)
      #topics_menu(category)
      display_index = 0
    end
  end

  def topics_menu(category, display_index = 9)
    input = nil
    #display_index += 9
      puts "Enter the number of the topic that you'd like to learn about. Type 'next' to display the next 10 topics. Type 'cat' to return to categories menu. Type 'exit' to quit."
      input = gets.strip.downcase
      if input.to_i > 0 && input.to_i <= category.topics.count
        topic = category.topics[input.to_i - 1]
        list_sections(topic)
        sections_menu(topic)
        input = 'exit'
      elsif input == "next"
        display_index = list_topics(category, display_index)
        topics_menu(category, display_index)
      elsif input == "cat"
        list_categories
        categories_menu
        input = "exit"
      end
    #{}end
  end

  def list_sections(topic)
    if topic.sections.count == 1
      #display_section(topic.sections[0])
      puts "How to #{topic.title}"
      puts topic.intro
    else
      puts topic.intro
      topic.sections.each.with_index(1) {|section, i|puts "#{i}. #{section[:section_title]}"}
    end
  end

  def sections_menu(topic)
    if topic.sections.count == 1
      display_section(topic.sections[0])
      list_topics(topic.category)
      topics_menu(topic.category)
    else
      input = nil
      #while input != "exit"
        puts "Enter the number of the section/method you'd like to learn about. Type 'topic' to return to Topics menu. Type 'exit' to quit"
        input = gets.strip.downcase
        if input.to_i > 0 && input.to_i <= topic.sections.count
          display_section(topic.sections[input.to_i - 1])
          list_sections(topic)
        elsif input == "topic"
          list_topics(topic.category)
          topics_menu(topic.category)
          #input = 'exit'
        else
          sections_menu(topic)
        end
      #end
    end
  end

  def display_section(section)
     step_number = 1
     input = nil
     while input != "topic" && step_number <= section[:section_steps].count
         step_description = section[:section_steps][step_number - 1]
         list_step(step_description, step_number)
         if step_number == section[:section_steps].count
           puts "Those are all the steps!"
         else
           puts "Press enter for next step. Type 'topic' to view sections/methods."
           input = gets.strip.downcase
        end
         step_number += 1
     end
  end

  def list_step(step_description, step_number)
    step_description.each do |layer_1|
      (layer_1.is_a? Array) ? display_first_layer_list(layer_1) : puts("\n#{yellow_text("#{step_number}. #{layer_1}")}")
    end
  end

  def display_first_layer_list(layer_1)
    layer_1.each do |layer_2|
      (layer_2.is_a? Array) ? display_second_layer_list(layer_2) : puts("\n#{green_text(" > #{layer_2}")}\n")
    end
  end

  def display_second_layer_list(layer_2)
    layer_2.each do |layer_3|
      puts("\n#{blue_text("    >> #{layer_3}")}\n")
    end
  end

  def good_bye
    puts "Goodbye!"
  end

  def red_text(string)
    color_text(string, @@red)
  end

  def green_text(string)
    color_text(string, @@green)
  end

  def blue_text(string)
    color_text(string, @@blue)
  end

  def yellow_text(string)
    color_text(string, @@yellow)
  end

  def color_text(string, color)
    "\e[#{color}m#{string}\e[0m"
  end
end
