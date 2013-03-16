PollsterApp::Application.routes.draw do
  resources :users, only: [:show, :index]
  resources :polls, only: [:create, :show, :update]

  root to: 'static_pages#home'
  match "/auth/:provider/callback" => "sessions#create"
  match "/signout" => "sessions#destroy", :as => :signout
  match '/about', to: 'static_pages#about'
  match '/help', to: 'static_pages#help'
end
