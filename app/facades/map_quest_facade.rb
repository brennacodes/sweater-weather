class MapQuestFacade
  def self.verify_location(location)
    MapQuestService.get_coordinates(location)
  end
end