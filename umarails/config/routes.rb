Rails.application.routes.draw do
  get '/races', to: 'race#races'
  get '/races/:race_id', to: 'race#race'
end
