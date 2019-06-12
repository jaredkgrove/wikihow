class Wikihow::Topic
  attr_accessor :url, :title, :intro, :author#TODO
  attr_reader :category
  def initialize(topic_hash = nil, category = nil)
    self.title = topic_hash[:title] if topic_hash != nil
    self.url = topic_hash[:url] if topic_hash != nil
    self.category = category if category != nil
    self.sections = nil
    @steps = []
  end

  def category=(category)
    @category = category
    category.add_topic(self)
  end

  def sections
    if @sections == nil
      @sections = self.scrape_topic
    end
    @sections
  end

  def sections=(sections)
    @sections = sections
  end

  def scrape_topic
    doc = Nokogiri::HTML(open(self.url))

    self.intro = doc.search("#intro p").last.text
    self.sections = []
    doc.search("#intro #method_toc .toc_method").each do |method|
      self.sections << {:section_title => method.text, :section_steps => []}
    end

    self.sections.each.with_index do |section, i|
      doc.search(".steps_list_2")[i].search(".step > text()").each do |section_li|
        main_description = section_li.text.strip
        section[:section_steps] << main_description


        doc.search(".steps_list_2")[i].search(".step > ul > li").each do |step_li|
          step_description = [step_li.css("> text()").text.strip]

          section[:section_steps] << step_description
        end
      end
    end
    binding.pry
    section_array
  end

  def self.sentence_to_snake_case(string)
    string.gsub(" ","_")
  end

  def self.snake_case_to_sentence(string)
    string.gsub("_"," ")
  end

  def self.get_or_create_topics_from_category(category)
    if category.topics == []
      self.scrape_for_topics(category).each{|topic_hash|self.new(topic_hash, category)}
    end
    category.topics
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
end
