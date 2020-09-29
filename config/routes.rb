# frozen_string_literal: true

Rails.application.routes.draw do
  resource :dashboard, :only => [:show]

  resources :services

  root :to => "dashboards#show"
end
