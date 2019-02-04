Rails.application.routes.draw do
  authenticated :user do
    root 'dashboard#index', as: :authenticated_root
  end

  root 'welcome#index'

  resources :dashboard, only: :index
  resources :jobs
  resources :conflicts

  resources :authors, shallow: true do
    resources :plays, shallow: true do
      resources :characters
      resources :character_groups
      resources :productions
      resources :acts, shallow: true do
        resources :scenes, shallow: true do
          resources :french_scenes, shallow: true do
            resources :on_stages
            resources :extras
            resources :lines, shallow: true
          end
        end
      end
    end
  end

  resources :theaters, shallow: true do
    resources :productions do
      resources :rehearsal_schedules do
        resources :rehearsals
        resources :default_rehearsal_attendees
      end
      resources :jobs
      member do
        get 'edit_casting'
        get 'doubling'
        get 'who_is_in_and_out'
      end
    end
  end

  resources :rehearsals do
    resources :rehearsal_materials
    resources :rehearsal_calls
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

  resources :users, except: :create

  post 'create_user' => 'users#create', as: :create_user

  get :build_rehearsal_schedule, to: 'rehearsal_schedules#build_rehearsal_schedule', as: :build_rehearsal_schedule
end
