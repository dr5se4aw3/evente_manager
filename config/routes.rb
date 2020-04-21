Rails.application.routes.draw do
  #ランディングページのルーティング
  devise_scope :user do
    root :to => "devise/sessions#new"
  end
  # ユーザーCRUD機能のルーティング
  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  resources :users, only:[:index, :show]

  # イベントCRUD機能のルーティング
  resources :events

  # イベント参加機能のルーティング
  resources :event_participants, only: [:index, :show, :create, :destroy]
end
