Rails.application.routes.draw do

  resources :default_rehearsal_attendees
  resources :rehearsal_calls
  resources :rehearsal_materials
  resources :conflicts
  resources :lines
  authenticated :user do
    root 'dashboard#index', as: :authenticated_root
  end

  root 'welcome#index'

  resources :dashboard, only: :index

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
    resources :productions do
      resources :rehearsal_schedules do
        resources :rehearsals
      end
      resources :jobs
      member do
        get 'edit_casting'
        get 'doubling'
      end
    end
  end

  resources :specializations
  resources :spaces
  resources :space_agreements, only: [:new, :create, :destroy]

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

  get :build_rehearsal_schedule, to: 'rehearsal_schedules#build_rehearsal_schedule', as: :build_rehearsal_schedule
end
