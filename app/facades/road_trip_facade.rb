class RoadTripFacade
  def self.create_trip(origin, destination)
    MapQuestService.get_travel_time(origin, destination)[:route]
  end
end