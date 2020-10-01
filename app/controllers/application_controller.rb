# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include DomainBasedGoogleAuthentication

  protect_from_forgery :with => :exception

  before_action :require_authorization
end
