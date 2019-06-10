class Wikihow::Category
  attr_accessor :name, :url, :topics
  def self.display
    category_1 = self.new
    category_1.name = "Arts & Crafts"
    category_1.url = "website.com/arts&crafts"
    #category_1.topics = [topic_1, topic_2]

    category_2 = self.new
    category_2.name = "Sports"
    category_2.url = "website.com/sports"
    #category_2.topics = [topic_11, topic_22]

    [category_1, category_2]
  end
end
