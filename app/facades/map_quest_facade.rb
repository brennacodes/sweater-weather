class MapQuestFacade
  def self.verify_location(location)
    MapQuestService.get_coordinates(location)
  end

  def self.get_coords(input)
    coordinates = verify_location(input)
    [
      coordinates[:results][0][:locations][0][:latLng][:lat], 
      coordinates[:results][0][:locations][0][:latLng][:lng]
    ]
  end
end