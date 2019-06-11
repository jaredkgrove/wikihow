class Wikihow::Topic
  attr_accessor :sections, :url, :title

  def initialize(topic_hash)
    self.title = topic_hash[:title]
    self.sections = {}
  end

  def self.get_or_create_from_category(category)
    if category.topics == []
      self.scrape_for_topics(category)

      category.topics << topic
    end
  end

  def self.scrape_for_topics(category)
    doc = Nokogiri::HTML(open("https://www.wikihow.com" + category.url))
    topics_array = []
    doc.search("#cat_container #cat_all a").each do |topic|
      title = topic.search("span").text
      url = topic.attr("href")
      topics_array << {:title => title,:url => url}
    end
    binding.pry
    topics_array
  end
end
