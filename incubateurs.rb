require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'

def page_list

lien_incub = "http://www.alloweb.org/annuaire-startups/annuaire-incubateurs-startups/"
page_list = []
doc = Nokogiri::HTML(open(lien_incub))
nb_page = ((doc.css("div[1]/div/div/div/div[2]/div/h3/span").text.to_i)/10.to_f).ceil #nombre max de page
i = 1
  while i <= nb_page

    if i == 1
    lien_incub = "http://www.alloweb.org/annuaire-startups/annuaire-incubateurs-startups/"
    page_list.push(lien_incub)
    elsif i > 1
    lien_incub = "http://www.alloweb.org/annuaire-startups/annuaire-incubateurs-startups/page/#{i}/"
    page_list.push(lien_incub.to_s)
    end
    i += 1
  end
  return page_list
end


def  page_incub(array_list)
  array_page = []
  array_list.each { |link|
  doc = Nokogiri::HTML(open(link))

    lien_page_incub = doc.css('h2.listing-row-title/a')
    lien_page_incub.each { |x|
    shift_href = x['href']
    array_page.push(shift_href.to_s)
    }
  }
  return array_page
end


def get_data (incub_link)
  array_data = []
  incub_link.each { |link|
  doc = Nokogiri::HTML(open(link))
  title = doc.css("h1.detail-title/text()").text
  website = (doc.css("#listing-detail-section-description > div > div:nth-child(1) > div > div > div > div > div > p:nth-child(7)")).at('a')
  #binding.pry
  unless website == nil
  href = website['href']
  array_data.push(Hash[:name => title, :link => href])
  end
}
puts array_data
end 

get_data(page_incub(page_list))