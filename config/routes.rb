Rails.application.routes.draw do
  # Establish route URL to these controller/view
  get 'main/home'
  get 'main/about'
  get 'contacts/form'

  # Shortens contacts_request_form to request_form in url - used for POST method only
  post 'request_form', to:'contacts#request_form'

  # This is the main home page the user will first load into
  root 'main#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
