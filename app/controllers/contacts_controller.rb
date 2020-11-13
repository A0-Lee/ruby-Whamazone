class ContactsController < ApplicationController
  def form
  end

  def request_form
    name = params[:name]
    email = params[:email]
    telephone = params[:telephone]
    message = params[:message]

    # A message is loaded into the flash container to be outputted in view
    flash[:notice] = I18n.t('contacts.request_form.form_sent')

    redirect_to root_path

  end
end
