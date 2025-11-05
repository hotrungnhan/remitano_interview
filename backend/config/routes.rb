Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  scope '/admin' do
    mount Rswag::Api::Engine => '/docs'
    mount Rswag::Ui::Engine => '/docs'
    mount GoodJob::Engine => '/good-jobs'
  end

  scope '/api/v1' do
    resources :auths, only: %i[index] do
      collection do
        post :login
        post :register
      end
    end
    resources :movies, only: %i[index show create destroy] do
      collection do
        # DELETE /movies
        delete :'', to: 'movies#bulk_destroy', as: :bulk_destroy
      end

      member do
        post :react
      end
    end
  end
end
