Rails.application.routes.draw do
  get '/customers/:id', to: 'customers#show'

  get '/supermarkets/:id', to: 'supermarkets#show'
  get '/supermarkets/:id/items', to: 'supermarket_items#index'
end
