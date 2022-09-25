class LocationsFacade
  def self.check_location(input)
    verify = CityVerifyService.get_city(input)
    verify.response.status == 200
  end

  def self.get_coordinates(input)
    if check_location(input) == true
      mapquest = MapquestService.get_coordinates(input)
      mapquest[:results][0][:locations][0][:latLng]
    else
      return "not found"
    end
  end
end