Rails.application.routes.draw do
  # Establish route URL to these controller/view
  get 'main/home'
  get 'main/about'
  get 'main/contact'

 # Standardise the related routes below
  get 'user/signup', to: 'users#signup'
  get 'user/login', to: 'sessions#login'
  get 'user/account', to: 'users#account'
  get 'user/logout', to: 'sessions#destroy'
  get 'user/edit', to: 'users#edit'

  delete 'remove_item', to: 'items#remove_item'

  # Contact form that uses mailer to send email (if it was linked to SMTP server)
  get 'contacts/form'

  # Reroutes contacts_request_form to request_form - used for POST method only
  post 'request_form', to:'contacts#request_form'

  # Get all the appropriate CRUD paths/routes for our resources
  resources :users
  resources :sessions
  resources :products, only: [:index, :show]
  resources :baskets
  resources :items

  # This is the first page the user will first load into as it is the root page
  root 'main#home'

  # We don't want those pesky unknown routes disturbing our user experience - redirects all unknown routes to root_path
  match '*path' => redirect('/'), via: :get
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
