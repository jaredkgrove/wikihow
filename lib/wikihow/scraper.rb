class Wikihow::Scraper
  def self.scrape_for_categories
    doc = Nokogiri::HTML(open("https://www.wikihow.com/Main-Page"))
    categories_array = []
    doc.search("#hp_categories a").each do |category|
      title = category.text
      url = category.attr("href")
      categories_array << {:title => title,:url => url}
    end
    categories_array
  end

  def self.scrape_for_topics(category)
    doc = Nokogiri::HTML(open("https://www.wikihow.com" + category.url))
    topics_array = []
    doc.search("#cat_container #cat_all a").each do |topic|
      title = topic.search("span").text.strip
      url = topic.attr("href")
      topics_array << {:title => title,:url => url} if title != ""
    end
    topics_array
  end

  def self.scrape_topic(topic)
    doc = Nokogiri::HTML(open(topic.url))

    topic.intro = doc.search("#intro p").last.text
    sections_array = []
    doc.search("#intro #method_toc .toc_method").each do |method|
      sections_array << {:section_title => method.text, :section_steps => []}
    end

    sections_array.each.with_index do |section, i|
      doc.search(".steps_list_2")[i].search(".step").each do |section_li|
        step_description = [section_li.search(".whb").text.strip + " " + section_li.search("> text()").text.strip]
        section_li.search("> ul > li").each do |step_li|
          bullet_point = [step_li.search("> text(), a").text.strip]
          sub_bullet_point = step_li.search("> ul > li").collect {|bullet_point_li|bullet_point_li.search("> text()").text.strip}
          bullet_point << sub_bullet_point if sub_bullet_point !=[]
          step_description << bullet_point if bullet_point != []
        end
        section[:section_steps] << step_description
      end
    end
    sections_array
  end
end
