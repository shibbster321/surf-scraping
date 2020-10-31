require 'nokogiri'
require 'open-uri'


def scrape(location)
  url = "https://www.surf-forecast.com/breaks/#{location}/forecasts/latest/six_day"
  html_file = open(url).read
  html_doc = Nokogiri::HTML(html_file)
  # set 0 values for loops
    i = 0 
    attributes = {}
    ratings = []; wave_height = []; wind_speed = []; wind_state = []; high_tide = []; low_tide = [];
  
  # scrap for each variable  
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
    html_doc.search(".forecast-table-wind__cell").each do |element|
        speed = element.css("text").text.to_i
        wind_speed << speed
    end
    html_doc.search(".forecast-table-wind-state__cell").each do |element|
        type = element.text
        wind_state << type
    end
    tide_info = html_doc.css("tr[data-row-name = 'high-tide']")
      tide_info.search(".forecast-table-tide__cell").each do |element|
        tide = element.css('div')[0].text
        high_tide << tide
      end
    tide2_info = html_doc.css("tr[data-row-name = 'low-tide']")
      tide2_info.search(".forecast-table-tide__cell").each do |element|
        tide2 = element.css('div')[0].text
        low_tide << tide2
      end
    # takes first one of first 3
    high_tide_1 = high_tide[1..3].find { |item| !item.empty? }
    high_tide_2 = high_tide[4..6].find { |item| !item.empty? }
    low_tide_1 = low_tide[1..3].find { |item| !item.empty? }
    low_tide_2 = low_tide[4..6].find { |item| !item.empty? }
  # pack items into attribute
    attributes[:rating] = [ratings[0], ratings[1], ratings[2], ratings[3], ratings[4], ratings[5] ]
    attributes[:location] = location
    attributes[:wave_height] = [wave_height[0], wave_height[1], wave_height[2], wave_height[3], wave_height[4], wave_height[5] ]
    attributes[:wind_speed] = [wind_speed[0], wind_speed[1], wind_speed[2], wind_speed[3], wind_speed[4], wind_speed[5] ]
    attributes[:wind_state] = [wind_state[0], wind_state[1], wind_state[2], wind_state[3], wind_state[4], wind_state[5] ]  
    attributes[:high_tide] = [high_tide_1, high_tide_2 ] 
    attributes[:low_tide] = [ low_tide_1, low_tide_2 ]
    return attributes
end
