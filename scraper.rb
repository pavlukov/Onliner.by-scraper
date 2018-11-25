require 'selenium-webdriver'
require 'capybara'

# Configurations
Selenium::WebDriver::Chrome.driver_path = "./chromedriver"
Capybara.register_driver :selenium do |app|  
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end
Capybara.javascript_driver = :chrome
Capybara.configure do |config|  
  config.default_max_wait_time = 10 # seconds
  config.default_driver = :selenium
end

browser = Capybara.current_session
driver = browser.driver.browser
browser.visit "https://www.onliner.by/"
links = browser.all(".cfix li a").map { |a| a["href"] }
links.delete_if { |link| link.include? "forum" or  link.include? "#comments" }
links.uniq!
titles = []
images = []
text = []
links.each do |link| 
	browser.visit(link) 

	titles.push(browser.title)

	text_str = ""
	browser.all(".news-text p").map { |element| text_str += element.text }
	text.push(text_str[0..200])

	browser.all(".news-header__image").map do |img| 
		img_url = img["style"] 
		images.push(img_url[/https..*.jpeg/])
	end
end 

puts titles[1]
puts images[1]
puts text[1]

=begin
puts links
puts
links.each do |link| 
	browser.visit link 
	puts browser.title
	puts browser.all(".news-text p").map { |element| element.text[0..200] }
	puts
end
=end

