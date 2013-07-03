require 'nokogiri'
require 'open-uri'
require 'pry'

#File.open('links.txt', 'w') do |f2|
#  for i in 0..9
#
#    i = "" if i ==0
#    url = "http://dir.indiamart.com/indianexporters/m_matool#{i}.html"
#
#    doc = Nokogiri::HTML(open(url))
#    doc.css('.w1.g2.g1.ad a').each do |link|
#      content = link.content
#      f2.puts content if content.include?("http")
#    end
#
#    puts "#{url} DONE"
#  end
#end


File.open('trade-india-links.txt', 'w') do |f2|
  for i in 0..9
    if i==0
      url = "http://www.tradeindia.com/Seller/Machinery/Machine-Tools/"
    else
      url = "http://www.tradeindia.com/Seller/Machinery/Machine-Tools/page-#{i}.html"
    end

    doc = Nokogiri::HTML(open(url))

    doc.css("a[@target='_blank']").each do |link|
      content = link.content
      f2.puts content if content.include?("http")
    end

        puts "#{url} DONE"
  end
end

