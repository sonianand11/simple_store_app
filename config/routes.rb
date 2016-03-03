Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do      
      resources :stores do
        resources :products
      end
      resources :users
    end
  end
end
