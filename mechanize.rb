
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'
require 'mechanize'

# Create a new instance of Mechanize and grab our page
agent = Mechanize.new
page = agent.get('http://robdodson.me/blog/archives/')

# Find all the links on the page that are contained within
# h1 tags.
post_links = page.links.find_all { |l| l.attributes.parent.name == 'h1' }

# Click on one of our post links and store the response
post = post_links[1].click
doc = post.parser # Same as Nokogiri::HTML(page.body)
p doc