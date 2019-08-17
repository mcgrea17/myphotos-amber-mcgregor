Rails.application.routes.draw do
  devise_for :users
  resources :locations
  resources :people
  root 'photos#index'
  resources :photos do
    resources :photopeople
  end
end
