Rails.application.routes.draw do
  resources :lenders
  resources :clients
  resources :applicants
  resources :contacts do 

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

    get '/edit_status' => 'application_cases#edit_status'
  end
  resources :cases
  resources :cases
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, :path_prefix => 'my'

  resources :users do
    resources :application_cases
  end

  get '/show_clients' => 'users#clients_index'
  get '/show_agents' => 'users#agents_index'

  get '/add_new_client' => 'users#add_new_client'
  get '/my_clients' => 'users#my_clients'


  get '/client_cases' => 'application_cases#client_cases'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'statics#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  resources :statics

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
