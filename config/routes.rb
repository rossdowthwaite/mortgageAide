Rails.application.routes.draw do
  
  resources :application_statuses
  resources :application_statuses
  resources :statuses
  # resources :lenders
  
  resources :clients do 
    get 'cases', on: :member
  end
  
  resources :applicants
  
  resources :contacts do 
    resources :contact_addresses
    resources :phone_numbers
    resources :extra_details
  end
  
  resources :mortgage_addresses
  
  resources :case_requirements
  
  resources :requirements
  
  resources :notes
  
  resources :roles

  resources :application_cases do 
    resources :notes
    resources :case_requirements
    resources :applicants
    resources :application_statuses

    get 'edit_status', as: :edit_status
    get 'my_cases', as: :my_cases, on: :collection
    get '/search_agents' => 'application_cases#search_agents'
    post '/add_as_agent' => 'application_cases#add_as_agent'
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
  get '/new_case' => 'application_cases#new'
  get '/case_archive' => 'application_cases#case_archive'

  get '/search_users' => 'users#search_users'
  post '/add_as_client' => 'users#add_as_client'

  # Root path
  root 'statics#index' 


end
