Rails.application.routes.draw do
  #ランディングページのルーティング
  devise_scope :user do
    root :to => "devise/sessions#new"
  end

  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  resources :users, only:[:index, :show]
  resources :events
  resources :conversations do
    resources :messages
  end
end
