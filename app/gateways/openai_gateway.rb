# frozen_string_literal: true

# OpenaiGateway
class OpenaiGateway
  include HTTParty
  base_uri 'https://api.openai.com'

  def initialize
    @token = ENV['open_ai_token']
    @engine_model = ENV['engine_model']
    @regexp = /\W?\s?lain|\s?navi$?/
  end

  def ask(prompt:)
    return unless prompt&.present?

    body = body(prompt: prompt.gsub(@regexp, '')).to_json
    response = self.class.post("/v1/engines/#{@engine_model}/completions", headers:, body:)

    json_response = JSON.parse(response.body)

    choices = json_response['choices']
    return choices[0]['text'] if choices&.present?

    'Sorry, i wasn\'t not able to understand, please can you repeat your question? maybe rephrase it'
  end

  def headers
    {
      'Content-Type' => 'application/json',
      'Authorization' => "Bearer #{@token}"
    }
  end

  def body(prompt:)
    {
      prompt:,
      max_tokens: 50,
      temperature: 0.7,
      top_p: 1.0,
      n: 1
    }
  end
end
