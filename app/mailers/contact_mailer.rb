class ContactMailer < ApplicationMailer

  def contact_form_email(name, email, telephone, message)
    @name = name
    @email = email
    @telephone = telephone
    @message = message

    mail cc: @email
  end

end
