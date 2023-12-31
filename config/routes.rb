Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    post "users/guest_sign_in" => 'users/sessions#guest_sign_in'
  end
  root 'homes#top'
  get '/about' => 'homes#about'
  get '/search' => 'searches#search'
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
  resources :users, only: [:index, :show, :edit, :update] do
    member do 
      get :follows, :followers
    end
    resource :relations, only: [:create, :destroy]
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
