Rails.application.routes.draw do
  get 'search/search'
  root to: 'homes#top'
  get '/home/about' => 'homes#about'
  get '/search' => 'search#search'

  # deviceのルート
  devise_for :users, only: %i(sessions registrations), controllers: {
    registrations: 'users/registrations',
  }
  devise_for :admins, only: [:sessions], controllers: {
    sessions: 'admins/sessions',
  }

  # ゲストログイン
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  # user側のルート設定
  scope module: 'users' do
    resources :users, only: %i(show edit update) do
      # フォロー・フォロワー
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: :followings
      get 'followers' => 'relationships#followers', as: :followers
      # 退会
      get 'confirm' => 'users#confirm', as: :confirm
      patch 'out' => 'users#out', as: :out
    end

    resources :pets, only: %i(index create edit update destroy)

    resources :diaries do
      resources :comments, only: %i(create destroy)
      resource :favorites, only: %i(create destroy)
      get :calenders, on: :collection
      get :bookmarks, on: :collection
      resource :bookmarks, only: %i(create destroy)
    end

    resources :tags do
      get 'diaries', to: 'diaries#search'
    end

    resources :questions do
      resources :answers, only: %i(index create update destroy)
      get :history, on: :collection
    end
  end
end
