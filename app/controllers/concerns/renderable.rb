module Renderable
  def json_response(object, status = :ok)
    render json: object, status: status
  end

  def render_missing_location
    json_response({ errors: "Missing location parameter" }, :bad_request)
  end

  def render_invalid_location_input
    json_response({ errors: "Invalid location parameter. Please enter a location in 'City,STATE' format, where STATE is a two-letter abbreviation of the state (ex. 'CO' for 'Colorado')" }, :bad_request)
  end

  def render_user_exists
    json_response({ errors: "Email already exists" }, :conflict)
  end

  def render_missing_params
    json_response({ errors: "Missing required parameters" }, :bad_request)
  end

  def render_invalid_credentials
    json_response({ errors: "Invalid credentials" }, :unauthorized)
  end

  def render_invalid_params
    json_response({ errors: "Invalid parameters" }, :bad_request)
  end

  def render_password_mismatch
    json_response({ errors: "Password and password confirmation do not match" }, :bad_request)
  end

  def render_try_again
    json_response({ errors: "Please try your request again" }, :bad_request)
  end

  def render_something_wrong
    json_response({ errors: "Something went wrong. Try again or come back later." }, :conflict)
  end
end