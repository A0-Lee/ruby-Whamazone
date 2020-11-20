class UsersController < ApplicationController
  def signup
  end

  def account
    # Redirect to root page if user is not logged in
    if !user_logged_in
      redirect_to root_path
    end
  end

  # This method is used for the signup page
  def create
    if (is_password_field_valid())
      # Creates a user object using the sent form parameters
      @user = User.create(user_params)
      # If parameters are valid and adhere to rules of their respective column (e.g. datatype, unique etc.)
      if @user.valid?
        # Save user to the database with form parameters as values to respective columns
        @user.save
        session[:user_id] = @user.id
        flash[:notice] = I18n.t('users.signup.signup_successful')
        redirect_to root_path
      else
        # Username and Email uniqueness is handled by user.rb
        flash[:alert] = I18n.t('users.signup.signup_fail')
        redirect_to user_signup_path
      end
    else
      flash[:alert] = I18n.t('users.signup.signup_passwords_do_not_match')
      redirect_to user_signup_path
    end
  end


  private
    def user_params
      # Password is encrypted to a digest version using a secure hash algorithm from the ruby gem bcrypt
      params.require(:user).permit(:username, :name, :email, :password, :password_confirmation)
    end

    def is_password_field_valid
      if params[:user][:password] == params[:user][:password_confirmation]
        return true
      else
        return false
      end
    end
  end
