module Timable
  include ActionView::Helpers::DateHelper
  
  def create_road_trip(origin, destination, trip)
    details = get_trip_details(trip)

    RoadTrip.new({
      start_city: origin, 
      end_city: destination,
      travel_time: details[:travel_time],
      weather_at_eta: details[:weather_at_eta]
    })
  end

  def get_trip_details(trip)
    details = Hash.new

    rt = trip[:realTime]
    current = Time.now.to_i
    ending = current + rt 

    string_time = distance_of_time_in_words(current, current + rt).gsub(" and", ",")
    details[:travel_time] = string_time

    coords = trip[:legs][0][:maneuvers][-1][:startPoint]
    forecast = OpenWeatherService.get_forecast([coords[:lat], coords[:lng]])

    tz_offset = forecast[:timezone_offset]
    time_formatted = Time.at(ending, in: tz_offset).to_i
    dts = forecast[:hourly].map {|hour| hour[:dt]}
    forecast_dt = dts.find {|dt| dt >= time_formatted}
    arrival_forecast = forecast[:hourly].find {|f| f[:dt] >= forecast_dt }

    details[:weather_at_eta] = {}
    details[:weather_at_eta][:temperature] = arrival_forecast[:temp]
    details[:weather_at_eta][:conditions] = arrival_forecast[:weather][0][:description]
    details
  end
end