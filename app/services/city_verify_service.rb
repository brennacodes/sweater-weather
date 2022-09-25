class CityVerifyService
  def self.get_city(city)
    response = conn.get("search") do |req|
      req.params['text'] = city,
      req.params['lang'] = 'en',
      req.params['type'] = 'city',
      req.params['filter'] = "countrycode:US",
      req.params['apiKey'] = ENV['GEOAPIFY_API_KEY']
    end
    
    JSON.parse(response.body, symbolize_names: true)
  end

  private
    def self.conn
      Faraday.new("https://api.geoapify.com/v1/geocode/search")
    end
end