module Existable
  extend Renderable

  def user_precheck
    new_user?
    missing_params?
    given_valid_params?
    passwords_match?
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

  def passwords_match?
    return render_password_mismatch if params[:password] != params[:password_confirmation]
    true
  end
end