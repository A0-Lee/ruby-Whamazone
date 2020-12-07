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

      # If the user has created a basket in a previous sesssion, use the same basket
      # We first check if a user has a customer record
      if CustomerInfo.exists?(user_id: session[:user_id])
        @customerInfo = CustomerInfo.find_by user_id: session[:user_id]
          # If they do, find if the customer record is linked to an existing basket
        if Basket.exists?(customer_info_id: @customerInfo.id)
          # We want the most recent matching basket record, as many baskets can have the same customer info id
          @basket = Basket.where(customer_info_id: @customerInfo.id).order("created_at ASC").last
          # Ensure that the basket has not already been ordered
          if !(Order.exists?(basket_id: @basket.id))
            # Set basket session as appropriate
            session[:basket_id] = @basket.id
          end
        end
      end

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
    # Set the session basket id to null (basket session tied to user id)
    session[:basket_id] = nil
    flash[:notice] = I18n.t('sessions.login.logout_successful')
    redirect_to root_path
  end

end
