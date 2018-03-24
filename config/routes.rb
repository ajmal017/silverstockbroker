Rails.application.routes.draw do
  resources :posts, :stocks, :tags

  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#index'

  get '/news' => 'pages#news'
  get '/commentary' => 'pages#commentary'
  get '/backtests' => 'pages#backtests'

  get '/dashboard' => 'dashboard#index'
  get '/dashboard/all-posts' => 'dashboard#all_posts'
  get '/dashboard/commentary-posts' => 'dashboard#dash_commentary_posts'
  get '/dashboard/news-posts' => 'dashboard#dash_news_posts'
  get '/dashboard/backtest-posts' => 'dashboard#dash_backtest_posts'
  get '/dashboard/new' => 'dashboard#posts'
  get '/dashboard/symbols' => 'dashboard#symbols'

  devise_scope :user do
    get 'admin', to: 'devise/sessions#new'
  end
end
