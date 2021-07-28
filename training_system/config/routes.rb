Rails.application.routes.draw do
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  
  namespace :trainer do
    resources :courses
    resources :user_courses, only: [:create, :destroy]
    resources :course_subjects, only: [:create, :destroy]
  end
end
