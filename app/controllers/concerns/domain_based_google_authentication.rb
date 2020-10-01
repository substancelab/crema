# frozen_string_literal: true

# Methods for requiring the user to be authenticated with Google OAuth and an
# email account on @substancelab.com
module DomainBasedGoogleAuthentication
  private

  def access_denied
    if request.xhr?
      render :status => :access_denied, :text => "Denied!"
    else
      redirect_to "/auth/google_oauth2", :id => "sign_in"
    end
  end

  def authorized_domains
    [
      "@substancelab.com",
    ]
  end

  def authorized?
    return true if Rails.env.test?

    Rails.logger.info {
      "Checking authorization: #{session[:user_email].inspect}"
    }

    return unless session[:user_email].present?

    email = session[:user_email]
    email.end_with?(*authorized_domains)
  end

  def require_authorization
    access_denied unless authorized?
  end
end
