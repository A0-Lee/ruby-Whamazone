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
    if user_logged_in
      if CustomerInfo.exists?(user_id: session[:user_id])
        @userCustomerInfo = CustomerInfo.find_by user_id: session[:user_id]

        if Basket.exists?(customer_info_id: @userCustomerInfo)
          @userBaskets = Basket.where(customer_info_id: @userCustomerInfo.id).order("created_at ASC")

          @orderRecordMatches = false
          @userOrders = Array.new
          @userBaskets.each do |basket|
            if @order.basket_id == basket.id
              @orderRecordMatches = true
              @matchingBasket = Basket.find(basket.id)
            end
          end

          if !(@orderRecordMatches)
            flash[:alert] = "This Order does not belong to you."
            redirect_to root_path
          end
        else
          flash[:alert] = "No existing baskets."
          redirect_to root_path
        end
      else
        flash[:alert] = "Create a CustomerInfo during checkout to see your orders."
        redirect_to root_path
      end
    else
      # This section is for customers buying without a User account
      if !(user_logged_in)
        @thisOrder = Order.find(params[:id])
        @recentCustomerInfo = CustomerInfo.last

        if Basket.exists?(customer_info_id: @recentCustomerInfo.id)
          @thisBasket = Basket.find_by customer_info_id: @recentCustomerInfo.id
          if @thisOrder.basket_id == @thisBasket.id
            # If it matches then show the order just created
            @matchingBasket = @thisBasket
          else
            flash[:alert] = "This Order does not belong to you."
            redirect_to root_path
          end
        else
          flash[:alert] = "Could not find existing basket."
        end
      else
        flash[:alert] = "You do not have permission to view this."
        redirect_to root_path
      end
    end
  end

  # GET /orders/new
  def new
    @order = Order.new
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
            # It also check how many items are in the basket
            totalPrice = 0
            itemCount = 0
            @basket.items.each do |item|
              totalPrice += item.product.price
              itemCount += 1
            end

            params[:order][:orderTotal] = totalPrice

            if itemCount == 0
              flash[:alert] = "You need to have at least 1 item in your Basket to checkout."
              redirect_to root_path
            else
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
            end

          else
            flash[:alert] = "Could not find Basket in session."
            redirect_to root_path
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      if Order.exists?(params[:id])
        @order = Order.find(params[:id])
      else
        flash[:alert] = "This Order does not exist."
        redirect_to root_path
      end
    end

    # Only allow a list of trusted parameters through.
    def order_params
      # Since we aren't using a real payment system, there's no need to verify real credentials
      params.require(:order).permit(:basket_id, :card_number, :svc_number, :telephone, :message, :orderTotal, :deliveryDate)
    end
end
