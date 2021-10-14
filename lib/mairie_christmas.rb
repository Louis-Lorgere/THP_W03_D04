require 'rubygems'
require 'nokogiri'
require 'open-uri'


def get_townhall_email(townhall_url)
  page = Nokogiri::HTML(URI.open(townhall_url))
  return page.xpath("//main/section[2]//tbody/tr[4]/td[2]").text
end

def get_townhall_urls_and_name (directory_townhalls_url)
  page = Nokogiri::HTML(URI.open(directory_townhalls_url))
  main_url = "http://annuaire-des-mairies.com/"
  array_url_and_name_towns = Array.new
  page.xpath('//table[@class="Style20"]//a').each do |node| array_url_and_name_towns.push([main_url + node["href"].slice!(2..node["href"].length), node.text.capitalize]) end
  return array_url_and_name_towns
end

def get_townhalls_names_and_emails_array array_url_and_name_towns
  array_townhalls_name_and_emails = Array.new
  array_url_and_name_towns.each do |x| array_townhalls_name_and_emails.push({x[1] => get_townhall_email(x[0])}) end
  return array_townhalls_name_and_emails
end


def process
  directory_townhalls_url = "http://annuaire-des-mairies.com/val-d-oise.html"
  array_url_and_name_towns = get_townhall_urls_and_name(directory_townhalls_url)
  array_townhalls_name_and_emails = get_townhalls_names_and_emails_array(array_url_and_name_towns)
  return array_townhalls_name_and_emails
end

# process
puts process