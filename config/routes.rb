Rails.application.routes.draw do
  root to: 'homes#top'
  get '/home/about' => 'homes#about'

  devise_for :users, only: [:sessions, :registrations]
  devise_for :admins, only: [:sessions], :controllers => {
    :sessions => 'admins/sessions'
  }
end
