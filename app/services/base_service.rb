class BaseService
  private
    def self.parse_json(response)
      JSON.parse(response.body, symbolize_names: true)
    end

    def self.faraday_conn(url)
      Faraday.new(url) do |f|
        Faraday::FlatParamsEncoder.sort_params = false
        f.options.params_encoder = Faraday::FlatParamsEncoder
        f.adapter Faraday.default_adapter
      end
    end
end