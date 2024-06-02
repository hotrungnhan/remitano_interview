Rails.application.routes.draw do
  mount Rswag::Api::Engine => '/api-docs'
  mount Rswag::Ui::Engine => '/api-docs'

  get "up" => "rails/health#show", as: :rails_health_check
  mount GoodJob::Engine => 'good_job'

  resources :auths, only: %i[index] do
    collection do
      post :'login'
      post :'register'
    end
  end

  resources :movies, only: %i[index create]
end
