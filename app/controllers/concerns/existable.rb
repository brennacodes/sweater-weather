module Existable
  extends Renderable
  
  def user_precheck
    new_user?
    missing_params?
    given_valid_params?
    has_valid_credentials?
  end

  def new_user?
    return render_user_exists if User.email_exists?(params[:email])
    true
  end

  def missing_params?
    return render_missing_params if params[:email].nil? || params[:password].nil?
    true
  end

  def given_valid_params?
    return render_invalid_params if params[:email].empty? || params[:password].empty?
    true
  end

  def has_valid_credentials?
    return render_invalid_credentials if invalid_credentials?
    true
  end
end