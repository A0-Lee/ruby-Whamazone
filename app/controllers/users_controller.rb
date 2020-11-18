class UsersController < ApplicationController
  def login
  end

  # This method is used for the signup page
  def create
    if (is_password_valid())
      @user = User.new(user_params)
      if @user.save
        flash[:notice] = I18n.t('users.signup.signup_successful')
        redirect_to root_path
      else
        # Username and Email uniqueness is handled by user.rb
        flash[:alert] = I18n.t('users.signup.signup_fail')
        redirect_to users_signup_path
      end
    else
      flash[:alert] = I18n.t('users.signup.signup_passwords_do_not_match')
      redirect_to users_signup_path
    end
  end

  private
    def user_params
      # Password is encrypted to a digest version using a secure hash algorithm from the ruby gem bcrypt
      params.require(:user).permit(:username, :name, :email, :password)
    end

    def is_password_valid
      if params[:user][:password] == params[:user][:confirm_password]
        return true
      else
        return false
      end
    end
  end
