Rails.application.routes.draw do
  # generates URL routes, controller mappings for user authentication
  get "recipes/index"
  get "recipes/show"
  get "recipes/new"
  get "recipes/create"
  devise_for :users

  # defines the homepage
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # generates the stadard RESTful routes for a Users controller.
  resources :users do
    # this route belongs to one specific user.
    member do
      # update the current user's dietary profile.
      post :add_allergy # POST /users/:id/add_allergy
      delete :remove_allergy # DELETE /users/:id/remove_allergy

      post :add_preference # POST /users/:id/add_preference
      delete :remove_preference # DELETE /users/:id/remove_preference

      post :add_dislike # POST /users/:id/add_dislike
      delete :remove_dislike # DELETE /users/:id/remove_dislike

      post :add_recipe
      delete :remove_recipe
    end
  end

  # root "posts#index"
resources :recipes do
  collection do
    post :test_create
  end

    member do
    patch :update_recipe
  end
end
  resources :chats, only: [:new, :create, :show] do
    resources :messages, only: [:create]
  end

  # allows the user to update his own password
  resource :password, only: [:edit, :update]

end
