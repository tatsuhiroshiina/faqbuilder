Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }
  root to: 'toppages#index'
  get 'toppages/index'
  resources :users
  resources :posts do
    collection {post :import}
  end
  get 'download_csv', to: "posts#download_csv"
  get 'search' => 'posts#search'
  devise_scope :user do
    get "signup", :to => "users/registrations#new"
    get "login", :to => "users/sessions#new"
    get "logout", :to => "users/sessions#destroy"
  end
end
