class CustomerInfosController < ApplicationController
  before_action :set_customer_info, only: [:show, :edit, :update, :destroy]

  # GET /customer_infos
  # GET /customer_infos.json
  def index
    @customer_infos = CustomerInfo.all
  end

  # GET /customer_infos/1
  # GET /customer_infos/1.json
  def show
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

  # DELETE /customer_infos/1
  # DELETE /customer_infos/1.json
  def destroy
    @customer_info.destroy
    respond_to do |format|
      format.html { redirect_to customer_infos_url, notice: 'Customer info was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer_info
      @customer_info = CustomerInfo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def customer_info_params
      params.require(:customer_info).permit(:user_id, :customerName, :telephone, :address, :city, :county, :postcode)
    end
end
