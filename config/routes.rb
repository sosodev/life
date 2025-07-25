Rails.application.routes.draw do
  get "entries/show"
  get "entries/new"
  get "entries/create"
  get "entries/edit"
  get "entries/update"
  get "entries/destroy"
  get "journals/index"
  get "journals/show"
  get "journals/new"
  get "journals/create"
  get "journals/edit"
  get "journals/update"
  get "journals/destroy"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root to: "pages#dashboard", as: :dashboard

  resources :tasks do
    collection do
      get :parent_tasks
    end
  end
  resources :task_lists
  resources :calendar, only: [ :index ]
end
