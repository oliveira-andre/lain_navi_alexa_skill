# frozen_string_literal: true

# AlexaController
class AlexaController < ApplicationController
  # skip_before_action :verify_authenticity_token
  before_action :user

  def create
    handler = "#{intent}Handler".constantize
    params.merge!(question:) if handler == AskingHandler
    @json_response = handler.new(params).call

    render json: @json_response
  rescue StandardError => e
    puts e
    render json: DefaultIntentHandler.new(params).call
  end

  def intent
    params.dig(:request, :intent, :name) || 'DefaultIntent'
  end

  def question
    slots = params.dig(:request, :intent, :slots)
    "#{slots.dig(:questionPrefix, :value)} #{slots.dig(:question, :value)} #{slots.dig(:__Conjunction, :value)}"
  end
end
