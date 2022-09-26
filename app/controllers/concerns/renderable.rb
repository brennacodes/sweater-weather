module Renderable

  def render_missing_location
    render json: { error: 'Missing location parameter' }, status: 400
  end

  def render_invalid_location_input
    render json: { error: 'Invalid location parameter. 
                            Please enter a location in "City,STATE" format, 
                            where STATE is a two-letter abbreviation of the state (ex. "CO" for "Colorado")' }, status: 400
  end

  def render_user_exists
    render json: { error: 'Email already exists' }, status: 409
  end

  def render_missing_params
    render json: { error: 'Missing required parameters' }, status: 400
  end

  def render_invalid_credentials
    render json: { error: 'Invalid credentials' }, status: 401
  end

  def render_invalid_params
    render json: { error: 'Invalid parameters' }, status: 400
  end

  def render_password_mismatch
    render json: { error: 'Password and password confirmation do not match' }, status: 400
  end

  def render_try_again
    render json: { error: 'Please try your request again' }, status: 400
  end

  def render_something_wrong
    render json: { error: 'Something went wrong. Try again or come back later.' }, status: 409
  end
end