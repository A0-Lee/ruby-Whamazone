class BasketsController < ApplicationController
  before_action :set_basket, only: [:show, :edit, :update, :destroy]

  # GET /baskets
  # GET /baskets.json
  def index
    # Only an admin account can access this page
    if session[:user_id] != 0
      flash[:alert] = "Please add an item to your basket first."
      redirect_to root_path
    else
      @baskets = Basket.all
    end
  end

  # GET /baskets/1
  # GET /baskets/1.json
  def show
    if Basket.exists?(session[:basket_id]) && session[:basket_id] != nil
      # We only want to check the id, so we just call the id column only
      @sessionBasket = Basket.select(:id).find(session[:basket_id])
      # This checks if the session basket id matches the basket id
      # We don't want other people accessing each other's baskets!
      if @sessionBasket.id == @basket.id
      else
        flash[:alert] = "Basket id does not match your session id."
        redirect_to root_path
      end
    else
      flash[:alert] = "Could not find Basket Session id."
      redirect_to root_path
    end
  end

  # GET /baskets/new
  def new
    @basket = Basket.new
  end

  # GET /baskets/1/edit
  def edit
    if Basket.exists?(session[:basket_id]) && session[:basket_id] != nil
      flash[:notice] = "Please enter your details to proceed with checkout."
    else
      flash[:alert] = "Could not find Basket Session id."
      redirect_to root_path
    end
  end

  # POST /baskets
  # POST /baskets.json
  def create
    @basket = Basket.new(basket_params)

    respond_to do |format|
      if @basket.save
        format.html { redirect_to @basket, notice: 'Basket was successfully created.' }
        format.json { render :show, status: :created, location: @basket }
      else
        format.html { render :new }
        format.json { render json: @basket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /baskets/1
  # PATCH/PUT /baskets/1.json
  def update
    respond_to do |format|
      if @basket.update(basket_params)
        format.html { redirect_to checkout_order_path, notice: 'Checkout details successfully updated.' }
        format.json { render :show, status: :ok, location: @basket }
      else
        format.html { render :edit }
        format.json { render json: @basket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /baskets/1
  # DELETE /baskets/1.json
  def destroy
    @basket.destroy
    respond_to do |format|
      format.html { redirect_to baskets_url, notice: 'Basket was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_basket
      if params[:id] != nil && Basket.exists?(params[:id])
        @basket = Basket.find(params[:id])
      else
        params[:id] = nil
      end
    end

    # Only allow a list of trusted parameters through.
    def basket_params
      params.require(:basket).permit(:customerName, :address, :city, :county, :postcode)
    end

end
