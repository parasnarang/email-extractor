require 'nokogiri'
require 'open-uri'

websites = ['http://website1', 'https://website2']
regex = Regexp.new('/[\w.!#\$%+-]+@[\w-]+(?:\.[\w-]+)+/')

websites.each do |website|
  emails = []

  doc = Nokogiri::HTML(open(website))

  # Searching by css
  doc.css('.email_field').each do |email|
    emails.push(email)
  end

  # Searching by mailto links
  selector = "//a[starts-with(@href, \"mailto:\")]/@href"
  nodes = doc.xpath selector
  addresses = nodes.collect {|n| n.value[7..-1]}
  #Since mail-to can have multiple addresses separated by commas
  addresses.each do |address|
    address.split(',').each do |addr|
      emails << addr
    end
  end

  File.open('data-emails.txt', 'a') do |f|
    f.puts emails.uniq
    puts emails.uniq
  end

end


