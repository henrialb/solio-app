Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users
  root 'patients#index'
  namespace :api do
    resources :patients, only: %i[index show create destroy update]
  end
end
