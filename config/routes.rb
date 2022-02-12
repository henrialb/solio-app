Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users

  get 'patients/active', to: 'patients#active'

  resources :patients, only: %i[index show create destroy update]
  resources :patient_admissions, only: %i[index show create destroy update]
  resources :patient_files, only: %i[index show create destroy update]
  resources :patient_expenses, only: %i[index show create destroy update]
  resources :patient_relatives, only: %i[index show create destroy update]
  resources :patient_exits, only: %i[index show create destroy update]
  resources :patient_receivables, only: %i[index show create destroy update]
  resources :employees, only: %i[index show create destroy update]
  resources :employee_admissions, only: %i[index show create destroy update]
  resources :employee_exits, only: %i[index show create destroy update]
  resources :visits, only: %i[index show create destroy update]
end
