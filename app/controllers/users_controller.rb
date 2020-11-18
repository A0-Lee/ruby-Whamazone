class UsersController < ApplicationController
  def login
  end

  <%=# The create method is used on the signup page %>
  def create
    @user = User.new(user_params)
    	if @user.save
    		flash[:notice] = I18n.t('users.signup.signup_successful')
      else
        flash[:alert] = I18n.t('users.signup.signup_fail')
      end
      redirect_to root_path
  end

  private
    def user_params
      <%=# I know storing password as plain-text is a security issue but this is for development purposes %>
      params.require(:user).permit(:username, :name, :email, :password)
    end

    def is_password_valid
      if params[:password] != params[:confirm_password]
        return false
      else
        return true
    end


end
