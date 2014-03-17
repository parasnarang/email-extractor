require 'nokogiri'
require 'open-uri'

categories = File.open('tradeindia-category-links.txt').readlines
filename = 'tradeindia-sub-category-links.txt'

File.open(filename, 'a') do |f|
  categories.each do |category|
    doc = Nokogiri::HTML(open(category))

    doc.css("a[@class='categorylist']").each do |subcategory|
      content = subcategory.href
      f.puts content
      puts "#{subcategory} DONE"
    end
    puts "#{category} DONE"
  end
end
