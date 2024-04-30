Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root 'welcome#index'

  get 'about', to: 'welcome#about'
  get 'contact', to: 'welcome#contact'

  resources :posts do
    resources :comments, except: :show
  end

  resources :students
  resources :categories, except: :show

  namespace :api do
    namespace :v1 do
      resources :regions, only: %i[index show], defaults: { format: :json } do
        resources :provinces, only: :index, defaults: { format: :json }
      end

      resources :provinces, only: %i[index show], defaults: { format: :json }
    end
  end

  resources :orders do
    member do
      post :submit
      post :pay
      post :fail
      post :revoke
    end
  end
end

