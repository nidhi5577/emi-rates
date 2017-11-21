Rails.application.routes.draw do
  resources :emi_rates, only: [:index], :path => "emi-rates" 
end
