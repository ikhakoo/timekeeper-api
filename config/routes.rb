Rails.application.routes.draw do

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :time_entries
      resources :time_cards
    end
  end

end
