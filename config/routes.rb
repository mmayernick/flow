Cappuccinoflow::Application.routes.draw do

  resources :items do
    collection do
      get :recently
    end
    
    member do
      get :star
      get :unstar
    end
    
    resources :comments
  end
  
  resources :comments, :only => [:delete]

  resources :categories
  resources :users
  resource :session
  
  match '/signup' => 'users#new', :as => :signup
  match '/login' => 'session#new', :as => :login
  match '/logout' => 'session#destroy', :as => :logout
  match '/tag/:id' => 'items#list_for_tags', :as => :tag
  match '/tags/:id' => 'items#list_for_tags', :as => :tags
  match '/tags/*id' => 'items#list_for_tags', :as => :tags_by_folders
  match '/search/:id' => 'items#search', :as => :search
  match '/category/:id' => 'items#category', :as => :category
  match '/page/:page' => 'items#index'

  root :to => 'items#index'
end
