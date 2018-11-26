class Article
	attr_reader :title, :img_url, :text

	def initialize(title, img_url, text)
		@title = title
		@img_url = img_url
		@text = text
	end
end