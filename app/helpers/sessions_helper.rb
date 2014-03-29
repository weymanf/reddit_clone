module SessionsHelper

  def login!(user)
    @current_user = user
    session[:session_token] = user.reset_session_token!
  end

  def current_user
    return nil if session[:session_token].nil?
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def logged_in?
    !!current_user
  end



  def logout!(user)
    user.reset_session_token!
    session[:session_token] = nil
  end

  def require_log_in
    redirect_to new_session_url unless logged_in?
  end
end
