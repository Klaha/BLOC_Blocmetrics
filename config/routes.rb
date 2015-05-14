Rails.application.routes.draw do
  get '/registered_applications/read/:id', to: 'registered_applications#read', as: 'read_app'
  resources :registered_applications, only: [:index, :new, :create, :destroy, :show]
  
  namespace :api, defaults: { format: :json } do
    resources :events, only: [:create]
  end
  
  devise_for :users
  root to: 'welcome#index'
end
