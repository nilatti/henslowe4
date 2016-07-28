Rails.application.routes.draw do

  authenticated :user do
    root 'dashboard#index', as: :authenticated_root
  end

  resources :dashboard, only: :index

  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
  
  devise_scope :user do
    get '/login' => 'devise/sessions#new'
    get '/logout' => 'devise/sessions#destroy'
    
  end
 
  resources :users, :controller => "users" do
    get 'outward_show', on: :member
    get 'resend_invite', on: :member
  end
  
  resources :users do
    resources :jobs
  end

  root 'welcome#index'

  

  resources :authors, shallow: true do
    resources :plays do
      resources :characters
      resources :productions  
      resources :acts do
        resources :scenes do
          resources :french_scenes do
            resources :on_stages
          end
        end
      end
    end
  end

  resources :jobs, only: [:edit, :update, :new, :create]
  resources :plays

  resources :theaters, shallow: true do
    resources :spaces
    resources :productions do
      resources :rehearsals
      resources :jobs
      member do 
        get 'edit_casting'
      end
    end
  end
  
  resources :spaces
 
  resources :specializations

  resources :space_agreements, only: [:new, :create, :destroy]
 
  
end
