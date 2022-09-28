module Verifiable
  include Renderable

  def check_quantity(quantity)
    quantity = quantity.to_i if quantity.is_a?(String)
    quantity.is_a?(Integer) && quantity > 0
  end

  def check_input(location_input)
    return render_missing_location if location_input.nil? || location_input.gsub(" ", "").empty?
    return render_invalid_location_input if location_input.split(',').length < 2
    true
  end

  def check_unit_params(unit_input)
    return 'imperial' if unit_input.nil? || unit_input.empty?
    return 'standard' if unit_input.downcase == 'standard'
    return 'metric' if unit_input.downcase == 'metric'
    
    'imperial'
  end
end