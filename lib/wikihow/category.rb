class Wikihow::Category
  attr_accessor :title, :url, :topics
  @@all = []
  def initialize(category_hash)
    @title = category_hash[:title]
    @url = category_hash[:url]
    @topics = []
    self.class.all << self
  end

  def self.all
    @@all
  end

  def self.get_or_create_categories
    if self.all == []
      categories = self.scrape_categories
      categories.each{|category| self.new(category)}
    end
    #binding.pry
    self.all
  end

  def self.scrape_categories
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
