# frozen_string_literal: true

Rails.application.routes.draw do
  # Required by devise
  root to: 'home#index'

  devise_for :employees

  # To manage users outside of devise - basically create users from app
  scope '/admin' do
    resources :employees
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
