Rails.application.routes.draw do
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  namespace :trainer do
    resources :courses do
      post "start_subject"
      member do
        post "start_course"
      end
    end
    resources :user_courses, only: [:create, :destroy]
    resources :subjects
    resources :course_subjects, only: :update
  end

  namespace :trainee do
    resources :courses, only: [:index, :show]
    resources :course_subjects, only: [:show, :update]
    resources :user_course_subjects do
      member do
        put "start_subject"
      end
    end
    resources :user_tasks do
      member do
        put "start_task"
      end
    end
  end
end
