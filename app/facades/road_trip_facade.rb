class RoadTripFacade
  def self.create_trip(origin, destination)
    trip = MapQuestService.get_travel_time(origin, destination)[:route]
    details = get_trip_details(trip)

    RoadTrip.new({
      start_city: origin, 
      end_city: destination,
      travel_time: details[:travel_time],
      weather_at_eta: details[:weather_at_eta]
    })
  end

  private
    def self.get_trip_details(trip)
      details = Hash.new

      details[:travel_time] = trip[:formattedTime]
      
      rt = trip[:realTime]
      current = Time.now.to_i
      ending = current + rt 
      # trip_time = trip[:formattedTime]
      # format_time = trip_time.tr(":", " ").split(" ").map(&:to_i)
      # format_time.unshift(00) if format_time.length == 3
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