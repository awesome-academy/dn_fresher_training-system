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
    resources :user_courses, only: [:create, :destroy]
  end

  namespace :trainee do
    resources :courses
    resources :course_subjects, only: :update
  end
end
