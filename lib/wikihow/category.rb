class Wikihow::Category
  attr_accessor :title, :url, :topics
  @@all = []
  def initialize(category_hash)
    self.title = category_hash[:title]
    self.url = category_hash[:url]
    self.topics = []
    self.class.all << self
  end

  def add_topic(topic)
    self.topics << topic
  end

  def self.all
    @@all
  end

  def self.get_or_create_categories
    if self.all == []
      Wikihow::Scraper.scrape_for_categories.each{|category| self.new(category)}
    end
    self.all
  end
end
