# frozen_string_literal: true

module AuthorizationHelpers
  def sign_in_as(email)
    Rails.logger.debug {
      "[Authorization] (Test): Pretending to log in as #{email.inspect}"
    }
    # request.session[:user_email] = email
  end
end

RSpec.configure do |config|
  config.include AuthorizationHelpers, :type => :request
end
