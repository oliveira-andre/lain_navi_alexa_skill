# frozen_string_literal: true

# AskingHandler
class AskingHandler < ApplicationHandler
  def call
    message = OpenaiGateway.new.ask(prompt: params[:question]).strip
    plain_text(message)
  end
end
