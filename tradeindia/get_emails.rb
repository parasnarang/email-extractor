require 'nokogiri'
require 'open-uri'

websites = File.open('data-vendor-urls.txt').readlines
regex = Regexp.new('/[\w.!#\$%+-]+@[\w-]+(?:\.[\w-]+)+/')

websites.each do |website|
  emails = []

  doc = Nokogiri::HTML(open(website.strip))
  puts '-- Extracting from ' + website.strip

  # Searching by css
  doc.css('.email_field').each do |email|
    emails.push(email) unless email.include?('tradeindia')
  end

  # Searching by mailto links
  selector = "//a[starts-with(@href, \"mailto:\")]/@href"
  nodes = doc.xpath selector
  addresses = nodes.collect {|n| n.value[7..-1]}
  #Since mail-to can have multiple addresses separated by commas
  addresses.each do |address|
    address.split(',').each do |addr|
      emails << addr unless addr.include?('tradeindia')
    end
  end

  File.open('data-vendor-emails.txt', 'a') do |f|
    f.puts emails.uniq
    puts emails.uniq
  end

end


