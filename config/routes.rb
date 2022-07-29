# frozen_string_literal: true

Rails.application.routes.draw do
  scope defaults: { format: 'json' } do
    resources :events, only: %i(index show)

    resources :tickets, only: %i(index) do
      collection do
        post :buy
        post :reserve
      end
    end
  end
end
