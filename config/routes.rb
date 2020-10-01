# frozen_string_literal: true

Rails.application.routes.draw do
  # For authentication with Google/OmniAuth
  get "auth/:provider/callback", :to => "sessions#create"
  get "auth/failure", :to => redirect("/")

  resource :dashboard, :only => [:show]

  resources :agreements
  resources :customers
  resources :services
  resource :session, :only => [:destroy]

  root :to => "dashboards#show"
end
