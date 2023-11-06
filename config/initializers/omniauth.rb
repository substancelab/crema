# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider \
    :google_oauth2,
    ENV["GOOGLE_OAUTH_CLIENT_ID"],
    ENV["GOOGLE_OAUTH_SECRET"],
    :scope => "userinfo.email, userinfo.profile",
    :prompt => "select_account"
end

OmniAuth.config.allowed_request_methods = [:get]
