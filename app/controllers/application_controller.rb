class ApplicationController < ActionController::Base
  # Define global methods that can be used in other controllers/views
  helper_method :session_user, :user_logged_in

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

  def user_logged_in
    # A boolean version of session_user method -> if value is returned = true, if nil is returned = false
    !!session_user
  end
end
