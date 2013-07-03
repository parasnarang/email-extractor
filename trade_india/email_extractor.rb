require 'nokogiri'
require 'open-uri'
require 'pry'


websites = File.open('../trade-india-links.txt').read

websites.each_line do |website|
  doc = Nokogiri::HTML(open(website))
  raw_html = doc.content

  i = -1
  tag_indexes = []

  while i = raw_html.index('@',i+1)
    tag_indexes << i
  end

  next unless tag_indexes.any?

  tag_indexes.each do |index|
    strip = raw_html[index-30, 100]
    end_email_index = strip.index(".com")
    if end_email_index.nil?
      end_email_index = strip.index(".in")
      next if end_email_index.nil?
      end_email_index = end_email_index + 3
    else
      end_email_index = end_email_index + 4
    end

    strip = strip[0, end_email_index]

    left_email_index = 0
    strip.reverse.chars.to_a.each_with_index do |character, i|
      check= character =~ /[a-zA-Z0-9.-_@]/
      if check.nil?
        left_email_index = strip.length - i
        break
      end
    end
    puts strip[left_email_index..strip.length]
  end
end



#File.open('trade-india-links.txt', 'w') do |f2|
#  for i in 0..9
#    if i==0
#      url = "http://www.tradeindia.com/Seller/Machinery/Machine-Tools/"
#    else
#      url = "http://www.tradeindia.com/Seller/Machinery/Machine-Tools/page-#{i}.html"
#    end
#
#    doc = Nokogiri::HTML(open(url))
#
#    doc.css("a[@target='_blank']").each do |link|
#      content = link.content
#      f2.puts content if content.include?("http")
#    end
#
#    puts "#{url} DONE"
#  end
#end

