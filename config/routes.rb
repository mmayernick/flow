Flow::Application.routes.draw do

  resources :items do
    collection do
      get :url_images
    end
    resources :comments
  end
  
  resources :comments

  resources :users do
    get :reset_password, :on => :collection
    post :send_reset_password, :on => :collection
    get :recovery, :on => :collection
    post :set_new_password, :on => :collection
  end
  
  resource :session
  
  match '/logout' => 'sessions#destroy', :as => :logout
  match '/api' => 'pages#api', :as => :api_info

  root :to => 'items#index'
end
