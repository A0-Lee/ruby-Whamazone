class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
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
    # We first create a DateTime object using our form parameters
    @preferreddeliveryDateObject = DateTime.new(params[:order]["deliveryDate(1i)"].to_i, params[:order]["deliveryDate(2i)"].to_i, params[:order]["deliveryDate(3i)"].to_i, params[:order]["deliveryDate(4i)"].to_i, params[:order]["deliveryDate(5i)"].to_i)
    # Then we convert our preferred Delivery Date using to_i() - where to_i() converts Date Time into seconds since the Unix epoch
    @preferredDeliveryDate = @preferreddeliveryDateObject.to_i()
    @currentDateTime = DateTime.current().to_i()

    if @preferredDeliveryDate > @currentDateTime
      params[:order][:basket_id] = session[:basket_id]
      @basket = Basket.find(session[:basket_id])

      totalPrice = 0
      @basket.items.each do |item|
        totalPrice += item.product.price
      end

      params[:order][:orderTotal] = totalPrice

      @order = Order.new(order_params)

      respond_to do |format|
        if @order.save
          session[:basket_id] = nil
          format.html { redirect_to @order, notice: 'Order was successfully created.' }
          format.json { render :show, status: :created, location: @order }
        else
          format.html { render :new, alert: 'Error in creating Order.' }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
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
      params.require(:order).permit(:basket_id, :card_number, :svc_number, :telephone, :message, :orderTotal, :orderDate, :deliveryDate)
    end
end
