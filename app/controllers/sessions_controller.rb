# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :require_authorization

  def create
    user = request.env["omniauth.auth"]
    session[:user_email] = user.info.email
    redirect_to root_path
  end

  def destroy
    session[:user_email] = nil
    redirect_to root_path
  end
end
