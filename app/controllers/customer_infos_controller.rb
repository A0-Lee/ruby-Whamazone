class CustomerInfosController < ApplicationController
  before_action :set_customer_info, only: [:show, :edit, :update, :destroy]

  # GET /customer_infos
  # GET /customer_infos.json
  def index
    if session[:user_id] != 0
      flash[:alert] = "You do not have permission to access this page."
      redirect_to root_path
    else
      @customer_infos = CustomerInfo.all
    end
  end

  # GET /customer_infos/1
  # GET /customer_infos/1.json
  def show
    if user_logged_in
      @user = User.find(session[:user_id])

      if CustomerInfo.exists?(user_id: session[:user_id])
        @userCustomerInfo = CustomerInfo.find_by user_id: session[:user_id]
        # Check if current CustomerInfo record matches user's CustomerInfo
        if !(@customer_info.id == @userCustomerInfo.id)
          flash[:alert] = "Customer Info record does not match User id."
          redirect_to root_path
        end
      else
        flash[:alert] = "Create a new Customer Info during checkout."
        redirect_to root_path
      end
    else
      # This method is fine if only one person is using the website
      # If many people are using the website it may become problematic
      if !(user_logged_in)
        @recentCustomerInfo = CustomerInfo.last
        # Ensure that the parameter id and customerInfo id are the same data types
        # Otherwise it will not equal to each other
        if params[:id].to_s == @recentCustomerInfo.id.to_s
          # If it matches then show the order just created
        else
          flash[:alert] = "This is not your CustomerInfo."
          redirect_to root_path
        end
      else
        flash[:alert] = "You do not have permission to view this."
        redirect_to root_path
      end
    end
  end

  # GET /customer_infos/new
  def new
    # If user is logged in and already has a customer record: redirect to edit page
    if user_logged_in && CustomerInfo.exists?(user_id: session[:user_id])
      @userCustomerInfo = CustomerInfo.find_by user_id: session[:user_id]
      redirect_to @userCustomerInfo
    end

    @customer_info = CustomerInfo.new
  end

  # GET /customer_infos/1/edit
  def edit
    if user_logged_in
      @user = User.find(session[:user_id])

      if CustomerInfo.exists?(user_id: session[:user_id])
        @userCustomerInfo = CustomerInfo.find_by user_id: session[:user_id]
        # Check if current CustomerInfo record matches user's CustomerInfo
        if !(@customer_info.id == @userCustomerInfo.id)
          flash[:alert] = "Customer Info record does not match User id."
          redirect_to root_path
        end
      else
        flash[:alert] = "Create a new Customer Info during checkout."
        redirect_to root_path
      end
    else
      if !(user_logged_in)
        @recentCustomerInfo = CustomerInfo.last
        if params[:id].to_s == @recentCustomerInfo.id.to_s
          # If it matches then edit the order just created
        else
          flash[:alert] = "This is not your CustomerInfo."
          redirect_to root_path
        end
      else
        flash[:alert] = "You do not have permission to view this."
        redirect_to root_path
      end
    end
  end

  # POST /customer_infos
  # POST /customer_infos.json
  def create
    # A customer record doesn't necessarily have to include a user
    # But if it does, the same customer record will be reused again
    if user_logged_in
      params[:customer_info][:user_id] = session[:user_id]
    end

    @customer_info = CustomerInfo.new(customer_info_params)

    respond_to do |format|
      if @customer_info.save
        format.html { redirect_to @customer_info, notice: 'Customer info was successfully created.' }
        format.json { render :show, status: :created, location: @customer_info }

        if basket_in_session && Basket.exists?(session[:basket_id])
          @currentBasket = Basket.find(session[:basket_id])
          @currentBasket.update(customer_info_id: @customer_info.id)
        end
      else
        format.html { render :new }
        format.json { render json: @customer_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customer_infos/1
  # PATCH/PUT /customer_infos/1.json
  def update
    respond_to do |format|
      if @customer_info.update(customer_info_params)
        format.html { redirect_to @customer_info, notice: 'Customer info was successfully updated.' }
        format.json { render :show, status: :ok, location: @customer_info }
      else
        format.html { render :edit }
        format.json { render json: @customer_info.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer_info
      if CustomerInfo.exists?(params[:id])
        @customer_info = CustomerInfo.find(params[:id])
      else
        flash[:alert] = "This CustomerInfo does not exist."
        redirect_to root_path
      end
    end

    # Only allow a list of trusted parameters through.
    def customer_info_params
      params.require(:customer_info).permit(:user_id, :customerName, :telephone, :address, :city, :county, :postcode)
    end
end
