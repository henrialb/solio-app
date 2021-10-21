Rails.application.routes.draw do
  get 'employees/index'
  get 'employees/create'
  get 'employees/new'
  get 'employees/edit'
  get 'employees/show'
  get 'employees/update'
  get 'employees/destroy'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
