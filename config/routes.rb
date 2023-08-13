# frozen_string_literal: true

Rails.application.routes.draw do
  post 'webhooks/alexa', to: 'alexa#create'
end
