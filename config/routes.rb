Rails.application.routes.draw do
  resources :uploads
  devise_for :users
  resources :quizzes do
    resources :questions
    resources :replies, only: [:new, :create]
    resources :charts 
     get 'quizzes/download_xlsx'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'quizzes#index'
end
 