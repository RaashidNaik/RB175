require 'json'
require 'nokogiri'
require 'caxlsx'
require 'csv'

slashdot_articles = []
File.open("slashdot.xml", "r") do |f|
  doc = Nokogiri::XML(f)
  slashdot_articles = doc.css('item').map { |i|
    {
      title: i.at_css('title').content,
      link: i.at_css('link').content,
      summary: i.at_css('description').content
    }
  }
end