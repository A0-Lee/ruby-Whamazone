class ApplicationController < ActionController::Base
  # Define global methods that can be used in other controllers/views
  helper_method :session_user, :user_logged_in, :count_basket

  # Keeps track of the logged in user's attribute values in a session
  def session_user
    # If session user id exists (handled in sessions_controller) and if user id exists in database
    if session[:user_id] && User.exists?(session[:user_id])
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

  def session_basket
    if sesson[:basket_id]
      @session_basket = Basket.find(session[:basket_id])
    else
      @session_basket = nil
    end
  end

  def basket_in_session
    !!session_basket
  end

  def count_basket
    if Basket.exists?(session[:basket_id]) && session[:basket_id] != nil
      @basket = Basket.find(session[:basket_id])
      return @basket.items.count
    else
      return 0
    end
  end

end
