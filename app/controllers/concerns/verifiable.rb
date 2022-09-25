module Verifiable
  def check_input(location_input)
    json_missing_input if location_input.nil? || location_input.empty?
    verify_location(location_input)
  end

  def verify_location(location_input)
    search = ForecastFacade.verify_location(location_params)
  end

  def json_missing_input
    render json: { error: 'Missing location parameter' }, status: 400
  end
end