module Existable
  include Renderable

  def user_precheck
    return render_user_exists if !new_user?
    return render_missing_params if missing_params?
    return render_password_mismatch if password_mismatch?
    return render_invalid_params if given_empty_params?
  end

  def new_user?
    User.email_exists?(params[:email]) == false
  end

  def missing_params?
    params[:email].nil? || params[:password].nil? || params[:password_confirmation].nil?
  end

  def given_empty_params?
    params[:email].empty? || params[:password].empty?
  end

  def password_mismatch?
    params[:password] != params[:password_confirmation]
  end
end