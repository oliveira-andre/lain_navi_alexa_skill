# frozen_string_literal: true

# DefaultIntentHandler
class DefaultIntentHandler < ApplicationHandler
  def call
    plain_text('Welcome Lain, what can i do for you today?')
  end
end
