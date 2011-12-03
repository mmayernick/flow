Flow::Application.routes.draw do

  resources :items do
    collection do
      get :url_images
    end
    resources :comments
  end
  
  resources :comments

  resources :users
  resource :session
  
  match '/logout' => 'sessions#destroy', :as => :logout
  match '/api' => 'pages#api', :as => :api_info

  root :to => 'items#index'
end
