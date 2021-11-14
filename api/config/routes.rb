Rails.application.routes.draw do
  resources :todos

  # resources :users
  post 'users/login', users: 'users#login'
  post 'users/register', users: 'users#register'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
