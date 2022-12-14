class UsersController < ApplicationController
  def signup
    if user_logged_in
      flash[:alert] = "Logout first to create a new account."
      redirect_to root_path
    end
  end

  def account
    # Redirect to root page if user is not logged in
    if !(user_logged_in)
      flash[:alert] = "Login to your account to access this page."
      redirect_to root_path
    end
  end

  def edit
    if !(user_logged_in)
      redirect_to root_path
    else
      # Get the user's attribute details to edit
      @user = User.find(session[:user_id])
    end
  end

  # This method is used for the signup form
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

  # This method is used for the edit form
  def update
    # Check if user in session is valid first
    @user = User.find(session[:user_id])
    # Check if desired username already exists in the database - except their own username
    @checkUsername = User.where.not(username: params[:user][:username]).exists?
    # And check if desired email already exists in the database too - except their own email
    @checkEmail = User.where.not(email: params[:user][:email]).exists?
    if @user.valid? && @checkUsername && @checkEmail
      if @user.update(user_params)
        flash[:notice] = I18n.t('users.edit.edit_success')
        redirect_to root_path
      else
        flash[:alert] = I18n.t('users.edit.edit_fail')
        redirect_to user_edit_path
      end
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
