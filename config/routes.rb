Rails.application.routes.draw do
  root 'exchange_data#index'

  get '/fetch_data', to: 'exchange_data#fetch_data'
  post '/data_selection', to: 'exchange_data#data_selection'
end
