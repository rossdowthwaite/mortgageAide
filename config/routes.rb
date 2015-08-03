Rails.application.routes.draw do
  
  resources :client_agents
  resources :mail_notification_settings
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
    
    get 'find_client', as: :find_client, on: :member
    post '/add_as_applicant' => 'application_cases#add_as_applicant'

  end

  resources :users do
    resources :application_cases
    resources :extra_details  
    resources :mail_notification_settings
    resources :client_agents
    
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

  post '/send_email_notification' => 'notes#send_email_notification'
  post '/send_email_requirements_notification' => 'case_requirements#send_email_requirements_notification'


  get '/my_clients' => 'client_agents#index'

  # Root path
  root 'statics#index' 


end
