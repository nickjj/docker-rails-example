Rails.application.routes.draw do
  root to: 'pages#home'

  scope controller: :pages do
    get :up
  end

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  # Learn more about this file at: https://guides.rubyonrails.org/routing.html
end
