Rails.application.routes.draw do
  # Establish route URL to these controller/view
  get 'main/home'
  get 'main/about'

  get 'contacts/form'

  get 'products/new'

  # Declares a standard REST (Representational State Transfer) resource
  # In this case, submitting a POST request from contacts/form to our database
  resources :contacts

  # This is the main home page the user will first load into
  root 'main#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
