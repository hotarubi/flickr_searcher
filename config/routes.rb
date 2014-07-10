Rails.application.routes.draw do
  resources :photos, only: [:index] do
    collection do
      post :search
    end
  end
  root 'photos#index'
end
