class ContactsController < ApplicationController
  def form
  end

  def create
    render plain: params[:contact].inspect
  end
end
