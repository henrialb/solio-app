Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users

  get 'patients/all', to: 'patients#all'
  resources :patients, only: %i[index show create destroy update]

  resources :patient_receivables, except: %i[add edit]
  post 'patient_receivables/create_from_expenses', to: 'patient_receivables#create_from_expenses'
  post 'patient_receivables/create_from_monthly_fee', to: 'patient_receivables#create_from_monthly_fee'

  resources :patient_admissions, only: %i[index show create destroy update]
  resources :patient_files, only: %i[index show create destroy update]
  resources :patient_expenses, only: %i[index show create destroy update]
  resources :patient_relatives, only: %i[index show create destroy update]
  resources :patient_exits, only: %i[index show create destroy update]
  resources :employees, only: %i[index show create destroy update]
  resources :employee_admissions, only: %i[index show create destroy update]
  resources :employee_exits, only: %i[index show create destroy update]
  resources :visits, only: %i[index show create destroy update]
end
