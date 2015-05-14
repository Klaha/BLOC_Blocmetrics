Rails.application.routes.draw do
  get '/registered_applications/read/:id', to: 'registered_applications#read', as: 'read_app'
  resources :registered_applications, only: [:index, :new, :create, :destroy, :show]
  
  devise_for :users
  root to: 'welcome#index'
end
