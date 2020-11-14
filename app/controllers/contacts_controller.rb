class ContactsController < ApplicationController
  def form
  end

  def request_form
    name = params[:form][:name]
    email = params[:form][:email]
    telephone = params[:form][:telephone]
    message = params[:form][:message]

    ContactMailer.contact_form_email(name, email, telephone, message).deliver_now
    # A message is loaded into the flash container to be outputted in view
    flash[:notice] = I18n.t('contacts.request_form.form_sent')

    #render plain: name.inspect
    redirect_to root_path

  end
end
