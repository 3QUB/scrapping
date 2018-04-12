require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'

#Il faut laisser tourner le script 1 minute. J'affiche tout d'un coup!

def mairie (lien_mairie)
  mairie = Nokogiri::HTML(open(lien_mairie))
  mairie_h1 = mairie.css("div[1]/main/section[1]/div/div/div/h1").text.split(" - ") #On cherche le H1 et on split pour séparer le nom et le Zip Code
  mairie_name = mairie_h1[0]
  mairie_postal_code = mairie_h1[1]
  mairie_email = mairie.css("div[1]/main/section[2]/div/table/tbody/tr[4]/td[2]").text
  h = Hash[:name => mairie_name,:zip_code => mairie_postal_code, :email => mairie_email, :source => lien_mairie]
  return h
end

def scan_list_mairie (lien)
  url_origin = "http://annuaire-des-mairies.com/"
  list_mairie = []
  page_origin = Nokogiri::HTML(open(lien))
  mairie_link = page_origin.css('a.lientxt')
  mairie_link.each {|x|
    link = x['href']
    link_to_mairie = URI.join(url_origin, link).to_s
    list_mairie.push(mairie(link_to_mairie))
}
puts list_mairie
end

def perform
  url_origin = "http://annuaire-des-mairies.com/val-d-oise.html"
  scan_list_mairie(url_origin)
end

perform