Rails.application.routes.draw do
  get 'sessions/login'
  # Establish route URL to these controller/view
  get 'main/home'
  get 'main/about'
  get 'main/contact'

 # Standardise the related routes below
  get 'user/signup', to: 'users#signup'
  get 'user/login', to: 'sessions#login'
  get 'user/logout', to: 'sessions#destroy'

  # Contact form that uses mailer to send email (if it was linked to SMTP server)
  get 'contacts/form'

  # Reroutes contacts_request_form to request_form - used for POST method only
  post 'request_form', to:'contacts#request_form'

  # Get all the appropriate CRUD paths for our resources
  resources :users
  resources :sessions

  # This is the first page the user will first load into as it is the root page
  root 'main#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
