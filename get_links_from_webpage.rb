require 'nokogiri'
require 'open-uri'

fail("Usage: ruby get_links_from_webpage.rb URL [URL ...]") if ARGV.empty?

ARGV.each do |url|
    filename = 'links-from-' + url.tr('^A-Za-z0-9', '') + '.txt'

    File.open(filename, 'w') do |f|
        doc = Nokogiri::HTML(open(url.strip))

        hrefs = doc.css("a").map do |link|
            if (href = link.attr("href")) && !href.empty?
                URI::join(url, href)
            end
        end.compact.uniq
        f.puts hrefs.join("\n")

        puts "#{url} DONE"
        puts "File created : #{filename}"
    end
end