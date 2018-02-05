Rails.application.routes.draw do
  root "flights#index"
  resources :bookings, only: [:show, :new, :create]
end
