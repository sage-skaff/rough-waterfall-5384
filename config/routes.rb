Rails.application.routes.draw do
  get '/customers/:id', to: 'customers#show'

  get '/supermarkets/:id', to: 'supermarkets#show'
end
