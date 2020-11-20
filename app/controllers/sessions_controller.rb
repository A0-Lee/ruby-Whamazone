class SessionsController < ApplicationController
  # This is used for the login view
  def login
  end

# This method is used for the user login function
  def create
    # Find the user in the database where email is equivalent to the form email parameter's value
    @user = User.find_by_email(params[:login][:email])
    # Check if user exists in the database (using the search above) and if the encrypted password (hashed using authenticate method) matches the password_digest
    if @user && @user.authenticate(params[:login][:password])
      session[:user_id] = @user.id
      flash[:notice] = I18n.t('sessions.login.login_successful')
      redirect_to root_path
    else
      flash[:alert] = I18n.t('sessions.login.login_fail')
      redirect_to user_login_path
    end
  end

# This method is used for the user logout function
  def destroy
    # Set the session user id to null (used to logout)
    session[:user_id] = nil
    flash[:notice] = I18n.t('sessions.login.logout_successful')
    redirect_to root_path
  end

end