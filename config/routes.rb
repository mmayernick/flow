Flow::Application.routes.draw do

  resources :items do
    collection do
      get :url_images
    end
    
    member do
      get :star
      get :unstar
    end
    
    resources :comments
  end
  
  resources :comments

  resources :categories
  resources :users do
    member do
      get :approve
      get :disapprove
    end
  end
  resource :session
  
  match '/logout' => 'sessions#destroy', :as => :logout
  match '/api' => 'pages#api', :as => :api_info

  root :to => 'items#index'
end
