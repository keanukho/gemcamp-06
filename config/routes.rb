Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root 'welcome#index'

  get 'about',   to: 'welcome#about'
  get 'contact', to: 'welcome#contact'

   resources :posts do
     resources :comments, except: :show
   end

  resources :students
  resources :categories, except: :show

end

