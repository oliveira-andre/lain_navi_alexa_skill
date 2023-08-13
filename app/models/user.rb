# frozen_string_literal: true

# User
class User < ApplicationRecord
  validates_presence_of :alexa_id
end
