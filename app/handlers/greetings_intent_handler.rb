# frozen_string_literal: true

# GreetingsIntentHandler
class GreetingsIntentHandler < ApplicationHandler
  def call
    plain_text('Hello Lain')
  end
end
