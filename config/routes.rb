Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post '/signup', to: 'users#create'
  post '/login', to: 'users#login'
  post '/create/post', to: 'posts#create'
  put '/update/post/:id', to: 'posts#update'
  delete '/delete/post/:id', to: 'posts#destroy'
end