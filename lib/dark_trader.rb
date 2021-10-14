require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'watir'

PAGE_URL = "https://coinmarketcap.com/all/views/all/"

def modify_values(values_crypto)
  values_crypto.map{|s| s.slice!(0); s.slice!(',')}
  values_crypto.map!{|s| s.to_f}
  return values_crypto
end

def get_names_crypto(page)
  names_crypto = Array.new
  page.xpath('//tbody//tr//td[2]//a[2]').each do |node| names_crypto.push(node.text) end
  return names_crypto
end

def get_values_crypto (page)
  values_crypto = Array.new
  page.xpath('//tbody//tr//td[5]//a').each do |node| values_crypto.push(node.text) end
  values_crypto = modify_values(values_crypto)
  return values_crypto  
end

def get_final_array(names_crypto, values_crypto)
  array_crypto_and_values = Array.new
  names_crypto.each do |x| array_crypto_and_values.push({x => values_crypto[names_crypto.index(x)]}) end
  return array_crypto_and_values
end

def process
  page = Nokogiri::HTML(URI.open(PAGE_URL))
  array_final = get_final_array(get_names_crypto(page), get_values_crypto(page))
  return array_final
end

# process
puts process