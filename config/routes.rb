Rails.application.routes.draw do

  root 'theaters#index'

  resources :authors, shallow: true do
    resources :plays do
      resources :characters
      resources :productions  
      resources :acts do
        resources :scenes do
          resources :french_scenes
        end
      end
    end
  end

  resources :plays

  resources :theaters, shallow: true do
    resources :spaces
    resources :productions do
      resources :rehearsals
    end
  end
  
 

  resources :specializations
  
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  match 'users/:id' => 'users#show', via: :get

  resources :users do
    resources :jobs
  end


  get '/secret', to: 'pages#secret', as: :secret
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
