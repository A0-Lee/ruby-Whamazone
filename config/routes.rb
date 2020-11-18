Rails.application.routes.draw do
  # Establish route URL to these controller/view
  get 'main/home'
  get 'main/about'
  get 'main/contact'

  get 'users/login'
  get 'users/signup'

  # Contact form that uses mailer to send email (if it was linked to SMTP server)
  # Accesed via url in contact page
  get 'contacts/form'

  # Shortens contacts_request_form to request_form in url - used for POST method only
  post 'request_form', to:'contacts#request_form'

  resources :users

  # This is the first page the user will first load into as it is the root page
  root 'main#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
