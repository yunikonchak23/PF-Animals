Rails.application.routes.draw do
  root to: 'homes#top'
  get '/home/about' => 'homes#about'

  # deviceのルート
  devise_for :users, only: [:sessions, :registrations], :controllers => {
    :registrations => 'users/registrations'
  }
  devise_for :admins, only: [:sessions], :controllers => {
    :sessions => 'admins/sessions'
  }

  # user側のルート設定
  scope module: 'users' do
    resources :users, only: [:show, :edit, :update] do
      # 退会機能のルート
      get 'confirm' => 'users#confirm', as: :confirm
      patch 'out' => 'users#out', as: :out
    end
    resources :pets, only: [:show, :create, :edit, :update, :destroy]
    resources :diaries do
      resources :comments, only: [:create, :destroy]
    end
    resources :questions do
      resources :answers, only: [:index, :create, :update, :destroy]
    end
  end

end
