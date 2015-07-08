Rails.application.routes.draw do
  
  # resources :lenders
  
  resources :clients do 
    get 'cases', on: :member
  end
  
  resources :applicants
  
  resources :contacts
  
  resources :mortgage_addresses
  
  resources :case_requirements
  
  resources :requirements
  
  resources :notes
  
  resources :roles

  resources :application_cases do 
    resources :notes
    resources :case_requirements
    resources :applicants

    get 'edit_status', as: :edit_status
    get 'my_cases', as: :my_cases, on: :collection
  end

  resources :users do
    resources :application_cases
    
    collection do 
      get 'clients_index',  as: :show_clients
      get 'agents_index',   as: :show_agents
    end
  end
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, :path_prefix => 'my'

  # Additional users Routes
  get '/add_new_client' => 'users#add_new_client'

  # Additional Application Routes
  get '/client_cases' => 'application_cases#client_cases'
  get '/my_cases' => 'application_cases#index'
  get '/my_cases/:id' => 'application_cases#show'

  # Root path
  root 'statics#index' 


end
