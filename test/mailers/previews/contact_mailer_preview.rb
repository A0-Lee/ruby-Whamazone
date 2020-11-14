# Preview all emails at http://localhost:3000/rails/mailers/contact_mailer
class ContactMailerPreview < ActionMailer::Preview
  def contact_form_email
    ContactMailer.contact_form_email("John Smith", "johnsmith@email.com", "0123 4567891", @message = "I would like some assistance with my purchase order id #123.")
  end
end
