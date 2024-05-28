Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  resources :auths do
    collection do
      post :'login'
      post :'register'
    end
  end

  resources :movies, only: %i[index create]
end
