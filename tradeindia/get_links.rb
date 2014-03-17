require 'nokogiri'
require 'open-uri'

filename = 'data-tradeindia-links.txt'
categories = File.open('data-tradeindia-sub-category-links.txt').readlines

File.open(filename, 'a') do |f|
  categories.each do |category|
    doc = Nokogiri::HTML(open(category.strip))
    last = doc.css("a[class='f4']").last[:href].scan( /\d+/ ).last.to_i
    puts "Total pages : #{last}"
    for i in 0..last
      if i==0
        url = category.strip
      else
        url = category.strip + "page-#{i}.html"
      end

      doc = Nokogiri::HTML(open(url))

      doc.css("a[@target='_blank']").each do |link|
        content = link.content
        f.puts content if content.include?('http')
      end

      puts "#{url} DONE"
    end
  end
end

