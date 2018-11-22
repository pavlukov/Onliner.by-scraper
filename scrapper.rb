require 'selenium-webdriver'
#require 'nokogiri'
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

# Visit
browser = Capybara.current_session
driver = browser.driver.browser
browser.visit "https://www.onliner.by/"