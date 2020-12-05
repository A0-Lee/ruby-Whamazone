class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  # Create a basket before adding in a Product item
  before_action :set_basket, only: [:create]

  # GET /items
  # GET /items.json
  def index
    @items = Item.all
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    # The product id is sent from the product show page using the Buy button
    product = Product.find(params[:product_id])
    quantity = params[:quantityOrdered]

    respond_to do |format|
      if product.quantityInStock > 0
        @item = @basket.items.build(product: product, quantityOrdered: quantity)

        if @item.save
          format.html { redirect_to @item.basket, flash: {notice: 'Item was successfully added.' }}
          format.json { render :show, status: :created, location: @item }
          # Reduce the stock quantity of the current product by 1 (as you can only add one product to the basket at a time)
          product.quantityInStock -= 1
          product.save
        else
          format.html { redirect_to @item.basket, flash: {alert: 'Something went wrong: Item could not be added.' }}
          format.json { render json: @item.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to product, flash: {alert: 'Cannot add item as it is out of stock.'}}
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item.basket, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def remove_item
    @item = Item.find(params[:id])
    product = Product.find(@item.product_id)

    if Basket.exists?(session[:basket_id]) && session[:basket_id] != nil
      @basket = Basket.find(session[:basket_id])
      @item.destroy
      # Increment the stock quantity of the current product by 1 (as you can only remove 1 product at a time)
      product.quantityInStock += 1
      product.save
      flash[:notice] = "Item was successfully removed."
      redirect_to @basket
    else
      flash[:alert] = "Could not find Basket Session id."
      redirect_to root_path
    end
  end


  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def item_params
      params.require(:item).permit(:basket_id, :product_id, :quantityOrdered)
    end

    # Check if basket is available to user or not
    def set_basket
      # Check if the current basket id session matches a record in the Basket table and that it is not nil
      if Basket.exists?(session[:basket_id]) && session[:basket_id] != nil
        @basket = Basket.find(session[:basket_id])
        session[:basket_id] = @basket.id
      else
        # Otherwise create a new basket depending if the user is logged in or not
        if user_logged_in
          # If user is logged in, check if an existing basket is aleady in use
          if Basket.exists?(user_id: session[:user_id])
            @basket = Basket.find_by user_id: session[:user_id]
            session[:basket_id] = @basket.id
          else
            # else create a new basket for the user, using their user id
            @basket = Basket.create(user_id: session[:user_id])
            session[:basket_id] = @basket.id
          end
        else
          # else create a new basket for a new session
          @basket = Basket.create
          session[:basket_id] = @basket.id
        end
      end
    end

end
