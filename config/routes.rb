Rails.application.routes.draw do
  resources :commentaries, :stocks
  resources :news

  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#index'

  get '/dashboard' => 'dashboard#index'
  get '/dashboard/commentary' => 'dashboard#commentary'
  get '/dashboard/symbols' => 'dashboard#symbols'
end
