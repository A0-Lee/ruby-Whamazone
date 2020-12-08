class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    if user_logged_in
      if CustomerInfo.exists?(user_id: session[:user_id])
        @customerInfo = CustomerInfo.find_by user_id: session[:user_id]

        if Basket.exists?(customer_info_id: @customerInfo.id)
          # Find all relevant baskets to the user's linked customerInfo.id
          @baskets = Basket.where(customer_info_id: @customerInfo.id).order("created_at ASC")
            # Append all the relevant orders into an array
          @orders = Array.new
          @baskets.each do |basket|
              # Check if basket has already been ordered
            if Order.exists?(basket_id: basket.id)
              @orders.append(Order.find_by basket_id: basket.id)
            end
          end
        end
      end
    else
      flash[:alert] = "Sign into your account to see your orders."
      redirect_to root_path
    end
    #@orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    # We first create a DateTime object using our form parameters, assuming they are not nil
    if params[:order]["deliveryDate(1i)"] != nil
      @preferreddeliveryDateObject = DateTime.new(params[:order]["deliveryDate(1i)"].to_i, params[:order]["deliveryDate(2i)"].to_i, params[:order]["deliveryDate(3i)"].to_i, params[:order]["deliveryDate(4i)"].to_i, params[:order]["deliveryDate(5i)"].to_i)
      # Then we convert our preferred Delivery Date using to_i() - where to_i() converts our Date Time object into seconds since the Unix epoch
      @preferredDeliveryDate = @preferreddeliveryDateObject.to_i()
    else
      # This is for the order controller test, where using the form parameters is complicated
      @preferredDeliveryDateObject = DateTime.current().next_day(10)
      @preferredDeliveryDate = @preferredDeliveryDateObject.to_i()
    end

    @currentDateTime = DateTime.current().to_i()

    # Ensure that we check the svc and card number are the correct lengths and that they are numbers
    # Since this is a practice website, no real payment system is in place (thankfully)
    @svcNumberParams = params[:order][:svc_number]
    @cardNumberParams = params[:order][:card_number]

    if @svcNumberParams != nil
      # The .delete() methods remove any white spaces and dots - We remove dots because our is_string_number? method also accepts float values
      @svcNumber = (params[:order][:svc_number]).to_s.delete(' ').delete('.')
    else
      @svcNumber = ""
    end

    if @cardNumberParams != nil
      @cardNumber = (params[:order][:card_number]).to_s.delete(' ').delete('.')
    else
      @cardNumber = ""
    end

    if @preferredDeliveryDate > @currentDateTime
      params[:order][:deliveryDate] = @preferredDeliveryDate

      if @svcNumber.length == 3 && is_string_number?(@svcNumber)
        # Never trust what credentials a User may enter in the form
        # Make sure that the parameters are as we expect it to be
        params[:order][:svc_number] = @svcNumber
        if @cardNumber.length == 16 && is_string_number?(@cardNumber)
          # Same logic applies here
          params[:order][:card_number] = @cardNumber

          # Get basket id using the same session id and find basket record
          if basket_in_session
            params[:order][:basket_id] = session[:basket_id]
            @basket = Basket.find(session[:basket_id])

            # This loop calculates the total price for all items in the basket
            totalPrice = 0
            @basket.items.each do |item|
              totalPrice += item.product.price
            end

            params[:order][:orderTotal] = totalPrice
          end

          @order = Order.new(order_params)

          respond_to do |format|
            if @order.save
              session[:basket_id] = nil
              format.html { redirect_to @order, notice: 'Order was successfully created.' }
              format.json { render :show, status: :created, location: @order }
            else
              puts @order.errors.full_messages
              format.html { render :new, alert: 'Error in creating Order.' }
              format.json { render json: @order.errors, status: :unprocessable_entity }
            end
          end

        else
          redirect_to checkout_details_order_path
          flash[:alert] = "Credit Number must contain 16 single-digit numbers."
        end

      else
        redirect_to checkout_details_order_path
        flash[:alert] = "SVC Number must contain 3 single-digit numbers."
      end
    else
      redirect_to checkout_details_order_path
      flash[:alert] = "Preferred Delivery Date must be greater than Current Date Time!"
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      # Since we aren't using a real payment system, there's no need to verify real credentials
      params.require(:order).permit(:basket_id, :card_number, :svc_number, :telephone, :message, :orderTotal, :deliveryDate)
    end
end
