require 'nokogiri'
require 'open-uri'

website = 'http://www.tradeindia.com'
categories = File.open('data-tradeindia-category-links.txt').readlines
filename = 'data-tradeindia-sub-category-links.txt'

File.open(filename, 'a') do |f|
  categories.each do |category|
    doc = Nokogiri::HTML(open(category))

    doc.css("a[@class='categorylist']").each do |subcategory|
      content = website + subcategory[:href]
      f.puts content
      puts "#{subcategory[:href]} DONE"
    end
    puts "#{category} DONE"
  end
end
