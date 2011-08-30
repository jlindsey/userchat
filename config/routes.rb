Userchat::Application.routes.draw do
  root :to => 'welcome#index'

  # Users
  match '/account' => 'users#edit'
  resources :users, :only => [:update]

  # Omniauth
  match '/signin' => 'services#signin'
  match '/signout' => 'services#signout'
  match '/auth/:service/callback' => 'services#create'
  match '/auth/failure' => 'services#failure'

  resources :services, :only => [:index, :create, :destroy] do
    collection do
      get 'signin'
      get 'signout'
      get 'failure'
    end
  end
end
