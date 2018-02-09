# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :prospects
  root 'reports/first_steps#new'

  resources :report, only: %i[new create show], controller: 'reports/first_steps'
  get "/pages/:page" => "pages#show"
  resources :reports, only: [] do
    resource :second_step, only: %i[new create edit update], controller: 'reports/second_steps'
    resource :third_step, only: %i[new create edit update], controller: 'reports/third_steps'
    resource :dashboard, only: :show, controller: 'reports/dashboards'

    get 'completed_tasks', to: 'charts#completed_tasks'
  end
end
