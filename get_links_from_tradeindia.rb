require 'nokogiri'
require 'open-uri'

filename = 'trade-india-links.txt'
File.open(filename, 'a') do |f2|
  for i in 0..9
    if i==0
      url = "http://www.tradeindia.com/Seller/Agriculture/Agriculture-By-product-Agents/"
    else
      url = "http://www.tradeindia.com/Seller/Agriculture/Agriculture-By-product-Agents/page-#{i}.html"
    end

    doc = Nokogiri::HTML(open(url))

    doc.css("a[@target='_blank']").each do |link|
      content = link.content
      f2.puts content if content.include?("http")
    end

        puts "#{url} DONE"
  end
end

