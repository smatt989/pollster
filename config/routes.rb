PollsterApp::Application.routes.draw do

  resources :users, only: [:show, :index]
  resources :polls, only: [:create, :index, :show, :update] do
    get :analytics, :on => :member
    get :previous, :on => :member
    get :next, :on => :member
  end
  resources :responses, only: [:create, :show]

  root to: 'static_pages#home'
  match "/auth/:provider/callback" => "sessions#create"
  match "/signout" => "sessions#destroy", :as => :signout
  match '/about', to: 'static_pages#about'
  match '/help', to: 'static_pages#help'
  match '/random', to: 'polls#random'
  match '/created', to: 'polls#created_index'
  match '/responded', to: 'polls#responded_index'
end
