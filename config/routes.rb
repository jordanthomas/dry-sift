Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post "/orders", to: "orders#create"

  resource :checkout, only: :new
end
