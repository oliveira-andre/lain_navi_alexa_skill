# frozen_string_literal: true

# ApplicationController
class ApplicationController < ActionController::API
  private

  def user
    @user ||= User.find_or_create_by!(alexa_id: alexa_user_id)
  end

  def alexa_user_id
    params.dig(:session, :user, :userId)
  end
end
