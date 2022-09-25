class CityVerifyService
  def self.get_city(city)
    response = conn.get do |req|
      req.url("search")
      req.params = { 
        text: city, 
        apiKey: ENV['GEOAPIFY_API_KEY'], 
        type: 'city', 
        lang: 'en', 
        limit: 1, 
        filter: 'countrycode:us' 
      }
    end
    
    JSON.parse(response.body, symbolize_names: true)
  end

  private
    def self.conn
      Faraday.new("https://api.geoapify.com/v1/geocode/") do |faraday|
        Faraday::FlatParamsEncoder.sort_params = false
        faraday.options.params_encoder = Faraday::FlatParamsEncoder
        faraday.adapter Faraday.default_adapter
      end
    end
end