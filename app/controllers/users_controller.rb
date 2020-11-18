class UsersController < ApplicationController
  def login
  end

  # This method is used for the signup page
  def create
    if (is_password_valid())
      @user = User.new(user_params)
      	if @user.save
      		flash[:notice] = I18n.t('users.signup.signup_successful')
        else
          flash[:alert] = I18n.t('users.signup.signup_fail')
        end
        redirect_to root_path
    else
      flash[:alert] = I18n.t('users.signup.signup_passwords_do_not_match')
      redirect_to users_signup_path
    end
  end

  private
    def user_params
      # I know storing password as plain-text is a security risk but this is for development purposes
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
