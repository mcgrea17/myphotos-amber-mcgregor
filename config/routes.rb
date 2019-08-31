Rails.application.routes.draw do
  root 'photos#index'
  devise_for :users
  resources :locations 
  resources :photos
  resources :people
  resources :albums

  resources :users, path: '' do 
    resource :photos do 
    end  
  end
    
end
