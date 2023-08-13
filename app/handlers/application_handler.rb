# frozen_string_literal: true

# ApplicationHandler
class ApplicationHandler
  def initialize(params)
    @params = params
  end

  attr_reader :params

  def plain_text(message, end_session: false) # rubocop:disable Metrics/MethodLength
    {
      version: '1.0',
      sessionAttributes: {},
      response: {
        shouldEndSession: end_session,
        outputSpeech: {
          type: 'PlainText',
          text: message
        }
      }
    }
  end

  def ssml(message, end_session: false) # rubocop:disable Metrics/MethodLength
    {
      version: '1.0',
      sessionAttributes: {},
      response: {
        shouldEndSession: end_session,
        outputSpeech: {
          type: 'SSML',
          ssml: message
        }
      }
    }
  end
end
