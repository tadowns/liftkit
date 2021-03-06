Rails.application.routes.draw do
  devise_for :users
  devise_scope :users do
    # The first entry is for devise. The second entry is for any other place we
    # navigate to /start, in case we change the user_root
    get 'start' => 'users#start', as: :user_root
    get 'start' => 'users#start', as: :start
  end

  root 'pages#home'

  resources :exercises
  resources :workouts
  post '/workouts/:workout_id/session' => 'seshions#create', as: :create_seshion

  get '/sessions/:id' => 'seshions#show', as: :seshions
  get '/sessions/:seshion_id/lifts/:id' => 'lifts#show', as: :seshion_lifts

  namespace :api do
    namespace :v1 do
      get '/workouts' => 'workouts#index'
      post '/workouts' => 'workouts#create'
    end
  end
end
