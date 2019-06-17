class Wikihow::Topic
  attr_accessor :url, :title, :intro, :author#TODO
  attr_reader :category
  def initialize(topic_hash = nil, category = nil)
    self.title = topic_hash[:title] if topic_hash != nil
    self.url = topic_hash[:url] if topic_hash != nil
    self.category = category if category != nil
    self.sections = []
  end

  def category=(category)
    @category = category
    category.add_topic(self)
  end

  def sections
    if @sections == []
      @sections = Wikihow::Scraper.scrape_topic(self)
    end
    @sections
  end

  def sections=(sections)
    @sections = sections
  end

  def self.get_or_create_topics_from_category(category)
    if category.topics == []
      Wikihow::Scraper.scrape_for_topics(category).each{|topic_hash|self.new(topic_hash, category)}
    end
    category.topics
  end
end
