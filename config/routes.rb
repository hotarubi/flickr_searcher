Rails.application.routes.draw do
  resources :photos, only: [:index] do
    collection do
      get :search
    end
  end
  root 'photos#index'
end
