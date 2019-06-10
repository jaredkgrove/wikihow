class Wikihow::Category

  def self.display
    puts <<-DOC.gsub /^\s*/, ''
      category 1
      category 2
      category 3
    DOC
  end
end
