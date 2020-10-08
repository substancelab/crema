# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include DomainBasedGoogleAuthentication

  protect_from_forgery :with => :exception

  before_action :require_authorization
  before_action :set_action_cable_identifier

  private

  def set_action_cable_identifier
    cookies.encrypted[:session_id] = session.id.to_s
  end
end
