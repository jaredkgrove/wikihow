class Wikihow::Topic
  attr_accessor :sections, :url, :title
  attr_reader :category

  def initialize(topic_hash = nil, category = nil)
    self.title = topic_hash[:title] if topic_hash != nil
    self.url = topic_hash[:url] if topic_hash != nil
    self.category = category if category != nil
    self.sections = {}
  end

  def category=(category)
    @category = category
    category.add_topic(self)
  end

  def self.get_or_create_from_category(category)
    if category.topics == []
      self.scrape_for_topics(category).each{|topic_hash|self.new(topic_hash, category)}
    end
    category.topics
  end

  def self.scrape_for_topics(category)
    doc = Nokogiri::HTML(open("https://www.wikihow.com" + category.url))
    topics_array = []
    doc.search("#cat_container #cat_all a").each do |topic|
      title = topic.search("span").text
      url = topic.attr("href")
      topics_array << {:title => title,:url => url}
    end
    topics_array
  end
end
