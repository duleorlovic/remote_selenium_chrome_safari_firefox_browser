# https://github.com/titusfortner/webdrivers
require 'webdrivers'

# https://github.com/SeleniumHQ/selenium/wiki/Ruby-Bindings
#
# driver = Selenium::WebDriver.for :chrome
# driver = Selenium::WebDriver.for :firefox
# driver = Selenium::WebDriver.for :safari
# driver = Selenium::WebDriver.for :remote, url: "http://localhost:4444/wd/hub"
# driver = Selenium::WebDriver.for :remote, url: "http://localhost:4444/wd/hub",  desired_capabilities: :firefox
# chrome needs seleniarm image
driver = Selenium::WebDriver.for :remote, url: "http://localhost:4444/wd/hub",  desired_capabilities: :chrome
### safari does not exists for docker
### driver = Selenium::WebDriver.for :remote, url: "http://localhost:4444/wd/hub",  desired_capabilities: :safari

driver.navigate.to "http://google.com"
body = driver.find_element(tag_name: "body")
puts body.text
# driver.quit

# this is applicably for local selenium from gems
# puts "Webdrivers::Chromedriver.current_version=#{Webdrivers::Chromedriver.current_version} Webdrivers::Chromedriver.driver_path=#{Webdrivers::Chromedriver.driver_path}"
