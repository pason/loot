Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  resources :users, except: :index do
    resources :transfers
  end
end
