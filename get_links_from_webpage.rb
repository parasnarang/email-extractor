require 'nokogiri'
require 'open-uri'

url = 'https://facebook.com'
filename = 'links-from-' + url.tr('^A-Za-z0-9', '') + '.txt'

File.open(filename, 'w') do |f|
    doc = Nokogiri::HTML(open(url))

    doc.css("a[@target='_blank']").each do |link|
      content = link.content
      f.puts content if content.include?("http")
    end

    puts "#{url} DONE"
    puts "File created : #{filename}"
end