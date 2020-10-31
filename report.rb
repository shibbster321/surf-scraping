class Report
    attr_accessor :location, :id, :rating, :wind_speed, :wind_state, :low_tide, :high_tide, :wave_height
    def initialize(attributes = {})
      @id = attributes[:id].to_i || 0
      @location = attributes[:location] || 0
      @rating = attributes[:rating].to_i || []
      @wind_speed = attributes[:wind_speed].to_i || []
      @wind_state = attributes[:wind_state].to_i || []
      @high_tide = attributes[:high_tide] || "unkown"
      @low_tide = attributes[:low_tide] || "unkown"
      @wave_height = attributes[:wave_height] || []
    end
  end
  