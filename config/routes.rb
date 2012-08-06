SportsBeat::Application.routes.draw do
  resources :athletes, :only => [:show]
  
  get "dashboard" => "dashboard#index", :as => :dashboard

  get "feeds/:owner_type/:owner_id/:name" => "feeds#show", :as => :feed

  resources :feed_entries, :only => [:show, :destroy]

  resources :games, :only => [:show]

  post "post_to/:subject_type/:subject_id" => "posts#create", :as => :post_to

  resources :posts, :only => [:show, :destroy]

  resources :schools, :only => [:index, :show]

  resources :sports, :only => [:index, :show] do
    member do
      get :positions
    end
  end

  resources :teams, :only => [:show] do
    member do
      get :games
      get :games_nearest
      get :roster
    end
  end

  #get 'users/auth/facebook' => 'omniauth_callbacks#facebook_set_variables'
  devise_for :users, :skip => :registrations, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  #devise_for :users
  resources :users, :only => [:index, :show]

  root :to => 'home#index'
end
