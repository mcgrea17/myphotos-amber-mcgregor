Rails.application.routes.draw do
  root 'photos#index'
  devise_for :users
  resources :locations 
  resources :photos
  

  resources :photos
  resources :people
 
  resources :photopeople
    
end
