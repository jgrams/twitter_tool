Rails.application.routes.draw do
  root 'users#new'
  get '/auth/:provider/callback' => 'users#create'
  get 'user/new' => 'users#new'
  post 'user/destroy' => 'users#destroy'
  get 'search/timeout' => 'searches#timeout'
  get 'search/show' => 'searches#show'
  get 'search/user_show' => 'searches#user_show'
  get 'search/twitter_show/:username' => 'searches#twitter_show'
  get 'search/database_show/:username' => 'searches#database_show'
  get 'search/fail' => 'searches#fail' 
  post 'search/create' =>  'searches#create'
  get 'search/create' =>  'searches#create'
  get 'example/show' => 'examples#show' 


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
  #     resources :products
  #   end
end
