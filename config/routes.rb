require 'resque/scheduler/server'

Rails.application.routes.draw do


mount Resque::Server.new, :at => '/resque'

  resources :reports do
    member do
      get 'showpdf'
    end
  end

  resources :grants
  devise_for :users
  resources :measurements do
    get 'autocomplete_technique_name', :on => :collection
  end

  resources :techniques
  resources :measurements
  get 'static_pages/home'

  get 'static_pages/help'

  resources :teams
  resources :institutions do
    get 'get_institutions', :on => :collection
  end
  
  resources :clients do
    resources :orders
  end  

  match 'clients/get_team_options/:institution_id', :controller=>'clients', :action => 'get_team_options' , :via  => 'get'
  match 'clients/get_clients_in_team/:team_id', :controller=>'clients', :action => 'get_clients_in_team' , :via  => 'get'
  match 'clients/get_client_grants/:client_id', :controller=>'clients', :action => 'get_client_grants' , :via  => 'get'
  match 'orders/get_grant_options/:client_id', :controller=>'orders', :action => 'get_grant_options' , :via  => 'get'
  match 'teams/get_team_grants/:team_id', :controller=>'teams', :action => 'get_team_grants' , :via  => 'get'
  match 'institutions/get_clients/:institution_id', :controller=>'institutions', :action => 'get_clients' , :via  => 'get'

    get 'orders/gotindex/:status' => 'orders#gotindex'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'static_pages#home'

  resources :orders do
    get 'autocomplete_client_name', :on => :collection
    post 'change_status', :on => :collection
    get 'get_alertcontent', :on => :collection
  end

  resources :orders

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

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
