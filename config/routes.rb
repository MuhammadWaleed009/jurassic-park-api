Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :cages do
    resources :dinosaurs, only: [:index, :create]
  end
  
  resources :dinosaurs, only: [:show, :update, :destroy]
end
