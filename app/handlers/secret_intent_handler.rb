# frozen_string_literal: true

# SecretIntentHandler
class SecretIntentHandler < ApplicationHandler
  def call
    message = OpenaiGateway.new.ask(prompt: 'tell me a almost unknown curiosity').strip
    speak = <<~SPEAK
      <speak>
        #{message}
        <amazon:effect name="whispered">But it is a secret to everybody</amazon:effect>.
      </speak>
    SPEAK

    ssml(speak)
  end
end
