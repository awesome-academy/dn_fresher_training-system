Rails.application.routes.draw do
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  
  namespace :trainer do
    resources :courses do
      member do
        post "start_course"
      end
    end
  end
end
