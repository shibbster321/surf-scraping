require 'nokogiri'
require 'open-uri'


def scrape(location)
  url = "https://www.surf-forecast.com/breaks/#{location}/forecasts/latest/six_day"
  html_file = open(url).read
  html_doc = Nokogiri::HTML(html_file)
  i = 1 
  attributes = {}
  ratings = []
  wave_height = []
  html_doc.search(".forecast-table__cell--has-image").each do |element|
    ratings << element.css("img").attribute("alt").value.to_i
  end
  html_doc.search(".forecast-table-wave-height__cell").each do |element|
    string = element.attribute("data-swell-state").value
    string = string.delete "\""
    array = string.split(',')
    height = array[3]
    height = height[/\d.*/].to_f
    wave_height << height
  end

  html_doc.search(".forecast-table-wave-height__cell").each do |element|
    string = element.attribute("data-swell-state").value
    string = string.delete "\""
    array = string.split(',')
    height = array[3]
    height = height[/\d.*/].to_f
    wave_height << height
  end
  # pack items into attribute
  attributes[:rating] = [ratings[0], ratings[1], ratings[2], ratings[3], ratings[4], ratings[5] ]
  attributes[:location] = location
  attributes[:wave_height] = [wave_height[0], wave_height[1], wave_height[2], wave_height[3], wave_height[4], wave_height[5] ]

  p attributes
  
  
  
  

  return attributes
end
# :wave_height_speed, :wave_height_state, :low_tide, :high_tide, :wave_height
# def get_prep_time(recipe)
#   url = recipe.description
#   html_file = open(url).read
#   html_doc = Nokogiri::HTML(html_file)
#   string = html_doc.search(".recipe-meta-item-body").text.strip
#   return string.split("\n").first
# end
# <td class="forecast-table__cell forecast-table__cell--has-image"><img alt="1" src="/staricons/star.1.gif" width="38" height="38"></td>

scrape("Port-Goret-Treveneuc")