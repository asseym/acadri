Rails.application.routes.draw do

  resources :tasks
  resources :rfqs
  resources :suppliers
  scope "cpny" do
    resources :assets
  end
  resources :expenses
  resources :accounts_invoice_items
  resources :profile_general_details
  resources :profile_bank_details
  resources :profile_contact_details
  resources :profile_personal_details
  resources :profiles
  resources :user_notifications
  resources :notifications
  resources :opportunities
  resources :accounts_invoices
  resources :trainings
  resources :participants
  resources :organisations
  resources :programs
  resources :program_venues
  resources :program_dates
  resources :categories
  resources :countries
  #devise_for           :users
  # devise_for :users, :path_prefix => 'dvs'
  devise_for :users, controllers: { sessions: 'users/sessions' }, :path_prefix => 'dvs'
  devise_scope :user do
    get '/dvs/users/sign_out' => 'users/sessions#destroy'
  end
  devise_for           :views
  resources  :users

  get '/search'      => 'static_pages#search'

  authenticated :user do
    root to: 'static_pages#index', as: :authenticated_root
  end
  root to: redirect('/dvs/users/sign_in')
  #get 'users'       => 'users#index'
  #get 'users/:id'   => 'users#show'
  #get 'signup'      => 'users#new'
  #get    'login'   => 'sessions#new'
  #post   'login'   => 'sessions#create'
  #delete 'logout'  => 'sessions#destroy'
  

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
  #     #   end
end
