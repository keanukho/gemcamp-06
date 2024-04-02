Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'welcome#index'
  get 'about', to: 'welcome#about'
  get 'contact', to: 'welcome#contact'
  get 'show', to: 'posts#show'
  get 'posts/new', to: 'posts#new'
  get 'posts/index', to: 'posts#index'
  resources :posts
end
