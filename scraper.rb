require 'selenium-webdriver'
require 'capybara'
require 'csv'
require './article.rb'

class Scraper
	attr_reader :articles

	def initialize(url)
		Selenium::WebDriver::Chrome.driver_path = "./chromedriver"
		Capybara.register_driver :selenium do |app|  
		  Capybara::Selenium::Driver.new(app, browser: :chrome)
		end
		Capybara.javascript_driver = :chrome
		Capybara.configure do |config|  
		  config.default_max_wait_time = 10 # seconds
		  config.default_driver = :selenium
		end

		@browser = Capybara.current_session
		driver = @browser.driver.browser
		@browser.visit url
		@articles = []
	end

	# get title, img_url, text
	def get_info
		links = @browser.all(".cfix li a").map { |a| a["href"] }
		@browser.all(".cfix figure a").map { |a| links.push(a["href"]) }
		links.delete_if { |link| link.include? "forum" or link.include? "#comments" or link.include? "kurs.onliner" }
		links.uniq!
		puts links
=begin
		links.each do |link| 
			@browser.visit(link) 

			title = @browser.title

			image = ""
			@browser.all(".news-header__image").map do |img| 
				img_url = img["style"] 
				image = img_url[/https..*.jpeg/]
			end

			text = ""
			@browser.all(".news-text p").map { |element| text += element.text }

			@articles.push(Article.new(title, image, text))
		end 
=end
	end

	def save
		file_path = "./onliner_articles.csv"
		CSV.open(file_path, "w") do |csv|
			@articles.each { |article| csv << [article.title, article.img_url, article.text[0..200]] } # delete [0..200] to save full text
		end
	end
end

scraper = Scraper.new("https://www.onliner.by/")
scraper.get_info
#scraper.save

