class Wikihow::Category
  attr_accessor :title, :url, :topics
  @@all = []
  def initialize(category_hash)
    @title = category_hash[:title]
    @url = category_hash[:url]
    @topics = []
    self.class.all << self
  end

  # def get_or_create_topics
  #   if self.topics == []
  #     self.scrape_for_topics
  #   end
  #   self.topics
  # end

  # def scrape_for_topics
  #   doc = Nokogiri::HTML(open("https://www.wikihow.com" + self.url))
  #   topics_array = []
  #   binding.pry
  #   # doc.search("#hp_categories a").each do |category|
  #   #   title = category.text
  #   #   url = category.attr("href")
  #   #   categories_array << {:title => title,:url => url}
  #   # end
  #   topics_array
  # end

  def self.all
    @@all
  end

  def self.get_or_create_categories
    if self.all == []
      self.scrape_for_categories.each{|category| self.new(category)}
    end
    #binding.pry
    self.all
  end

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
end
