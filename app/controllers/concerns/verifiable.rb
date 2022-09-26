module Verifiable
  def check_input(location_input)
    json_missing_input if location_input.nil? || location_input.empty?
  end

  def json_missing_input
    render json: { error: 'Missing location parameter' }, status: 400
  end
end