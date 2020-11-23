class MainController < ApplicationController
  def home
    # Render all the products on the home page
    @products = Product.all
  end

  def contact
  end

  def about
  end
end
