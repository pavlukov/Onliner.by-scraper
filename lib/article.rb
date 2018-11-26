# represents articles from the website
class Article
  attr_reader :title, :img_url, :text

  def initialize(title, img_url, text)
    @title, @img_url, @text = title, img_url, text
  end
end
