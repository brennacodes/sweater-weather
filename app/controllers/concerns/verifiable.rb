module Verifiable
  def check_input(location_input)
    return json_missing_location_input if location_input.nil? || location_input.empty?
    return json_invalid_location_input if location_input.split(',').length < 2
    true
  end

  def json_missing_location_input
    render json: { error: 'Missing location parameter' }, status: 400
  end

  def json_invalid_location_input
    render json: { error: 'Invalid location parameter. 
                            Please enter a location in "City,STATE" format, 
                            where STATE is a two-letter abbreviation of the state (ex. "CO" for "Colorado")' }, status: 400
  end

  def check_unit_params(unit_input)
    return 'imperial' if unit_input.nil? || unit_input.empty?
    return 'standard' if unit_input.downcase == 'standard'
    return 'metric' if unit_input.downcase == 'metric'
    
    'imperial'
  end
end