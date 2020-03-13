Rails.application.routes.draw do
  resources :tickets, only: [:create, :index, :show]
end
