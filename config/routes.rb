Rails.application.routes.draw do

  root                'static_pages#home'
  get    'help'    => 'static_pages#help'
  get    'about'   => 'static_pages#about'
  get    'contact' => 'static_pages#contact'
  get    'account' => 'static_pages#account'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get 'get_password' => 'sessions#get_password'
  post 'get_password' => 'sessions#new_password'
  get    'profile' => 'users#show'
  post 'statement' => 'payments#statement'
  post 'make_payment' => 'payments#make_payment'
  post 'update_user' => 'users#update_user'
  get 'change_password' => 'users#change_password'
  post 'update_password' => 'users#update_password'
  post 'create_invoice' => 'invoices#create_invoice'
  resources :credits, only: [:new, :create]
  resources :banks, only: [:new, :create]
  resources :invoices
  resources :accounts
  resources :records
  resources :payments
  resources :users


end
