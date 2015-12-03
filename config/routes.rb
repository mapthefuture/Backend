Rails.application.routes.draw do
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

  ## Registration Routes
  post "signup", to: "registrations#create"
  post "user/show", to: "registrations#show"
  patch "user/:id/update", to: "registrations#update"
  delete "user/destroy", to: "registrations#destroy"

  ## Tour Routes
  get "tours", to: "tours#index"
  post "tours", to: "tours#create"
  patch "tours/:id", to: "tours#update"
  get "tours/:id", to: "tours#show"
  delete "tours/:id", to: "tours#destroy"
 
  ## Site Routes
  get "tours/:id/sites", to: "sites#index"
  post "tours/:id/sites", to: "sites#create"
  patch "sites/:id", to: "sites#update"
  get "sites/:id", to: "sites#show"
  delete "sites/:id", to: "sites#destroy"

  ## Tour Rating Routes
  get "tours/:id/ratings", to: "tour_ratings#index"
  post "tours/:id/ratings", to: "tour_ratings#create"
  get "ratings/:id", to: "tour_ratings#show"
  patch "ratings/:id", to: "tour_ratings#update"
  delete "ratings/:id", to: "tour_ratings#destroy"
  get "tours/:id/ratings", to: "tour_ratings#mean"

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
