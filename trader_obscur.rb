require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'

def count_element (lien_cmc)
  
  doc = Nokogiri::HTML(open(lien_cmc))
  currency_list = []
  nb_currency = doc.search("tbody/tr").size
  i = 1

  while i < nb_currency
  name = doc.css("tbody/tr[#{i}]/td[2]/a").text #Bitcoin
  symbol = doc.css("tbody/tr[#{i}]/td[3]").text #Symbol
  price =  doc.css("tbody/tr[#{i}]/td[5]/a").text #Price
  var_hour = doc.css("tbody/tr[#{i}]/td[8]").text #%1H

  currency_list.push(Hash[:name => name, :symbol => symbol, :price =>price, :var_hour => var_hour])

  i += 1

  end

  puts currency_list

end

def perform
  cmc = "https://coinmarketcap.com/all/views/all/"
  count_element(cmc)
end

perform