Rails.application.routes.draw do
  root to: 'homes#top'
  get '/home/about' => 'homes#about'

  devise_for :users, only: [:sessions, :registrations], :controllers => {
    :registrations => 'users/users'
  }
  devise_for :admins, only: [:sessions], :controllers => {
    :sessions => 'admins/sessions'
  }

  scope module: 'users' do
    resource :users, only: [:show, :edit, :update] do
      get 'confirm'
      patch 'out'
    end
    resources :pets, only: [:index, :create, :edit, :update, :destroy]
    resources :diaries
  end

end
