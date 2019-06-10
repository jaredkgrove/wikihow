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
    doc = Nokogiri::HTML(open("https://www.wikihow.com" + self.url))
    topics_array = []
    binding.pry
    # doc.search("#hp_categories a").each do |category|
    #   title = category.text
    #   url = category.attr("href")
    #   categories_array << {:title => title,:url => url}
    # end
    topics_array
  end
end
