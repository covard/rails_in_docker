Rails.application.routes.draw do
  get 'pages/home'
  resources :users
  get 'welcome', to: 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
