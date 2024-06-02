Rails.application.routes.draw do
  scope '/admin' do
    mount Rswag::Api::Engine => '/docs'
    mount Rswag::Ui::Engine => '/docs'

    get "up" => "rails/health#show", as: :rails_health_check
    mount GoodJob::Engine => 'good_job'
  end

  scope '/api' do
    resources :auths, only: %i[index] do
      collection do
        post :'login'
        post :'register'
      end
    end

    resources :movies, only: %i[index create]
  end
end
