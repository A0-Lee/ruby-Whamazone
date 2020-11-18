class ApplicationController < ActionController::Base
  helper_method :session_user

  # Keeps track of the logged user's details in a session
  def session_user
    # If session user id exists (handled in sessions_controller)
    if session[:user_id]
      # Find the rest of the user's records from database
      @session_user = User.find(session[:user_id])
    else
      # Otherwise set the session user to null (same as logged out)
      @session_user = nil
    end
  end

end
