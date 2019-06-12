class Wikihow::Topic
  attr_accessor :url, :title, :intro, :author#TODO
  attr_reader :category
  def initialize(topic_hash = nil, category = nil)
    self.title = topic_hash[:title] if topic_hash != nil
    self.url = topic_hash[:url] if topic_hash != nil
    self.category = category if category != nil
    @steps = []
  end

  def category=(category)
    @category = category
    category.add_topic(self)
  end

  def steps
    if @steps == []
      @steps = self.scrape_topic
    end
    @steps
  end

  def steps=(steps)
    @steps = steps
  end

  def scrape_topic
    doc = Nokogiri::HTML(open(self.url))
    #sections_hash = {sectionname1=>{stepname=>steptext}
    section_array = []
    self.intro = doc.search("#intro p").last.text

    doc.search("#intro #method_toc .toc_method").each do |method|
      section_array << {:title => method.text}
    end
#[{:title=>method_title,:steps=>[]}]
     section_array.each.with_index do |section, i|
       main_description = doc.search(".steps_list_2")[i].search(".step").first.text
       steps_list = doc.search(".steps_list_2")[0].search(".step > ul > li")

       test = steps_list.css("> text()").collect do |step_li|
            step_li.text.strip
      #     #first_layer_list = step_li.text
      #     #step_li.search("li")
       end

      binding.pry
      #section_array[i]["step_#{i + 1}".to_sym] = {:step_description=>doc.search(".steps_list_2")[i].search(".step").first.text}
      end

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
