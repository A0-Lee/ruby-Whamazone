class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :set_product, only: [:new]

  # GET /reviews
  # GET /reviews.json
  def index
    if user_logged_in
      #@reviews = Review.all
      @reviews = Review.where(user_id: session[:user_id]).order("created_at ASC")
    else
      flash[:alert] = "Login to your account to see your reviews."
      redirect_to root_path
    end
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
  end

  # GET /reviews/new
  def new
    if user_logged_in
      # Make sure that a User can only have one Review per Product
      if Review.exists?(product_id: session[:product_id], user_id: session[:user_id])
        flash[:alert] = "You've already made a review of Product ID " + @product.id.inspect + "."
        redirect_to reviews_path
      else
        @review = Review.new
      end
    else
      flash[:alert] = "You need to be logged in to write a review."
      redirect_to root_path
    end
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @product = Product.find(session[:product_id])
    params[:review][:product_id] = session[:product_id]
    session[:product_id] = nil
    params[:review][:user_id] = session[:user_id]
    @review = Review.new(review_params)

    respond_to do |format|
      if @review.save
        format.html { redirect_to @review, notice: 'Review was successfully created.' }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @review, notice: 'Review was successfully updated.' }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to reviews_url, notice: 'Review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      if params[:id] != nil && Review.exists?(params[:id])
        @review = Review.find(params[:id])
      end
    end

    def set_product
      if params[:product_id] != nil && Product.exists?(params[:product_id])
        @product = Product.find(params[:product_id])
        session[:product_id] = @product.id
      end
    end

    # Only allow a list of trusted parameters through.
    def review_params
      params.require(:review).permit(:product_id, :user_id, :title, :comment, :rating)
    end
end
