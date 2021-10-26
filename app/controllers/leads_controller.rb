# frozen_string_literal: true

class LeadsController < ApplicationController
  # GET /leads
  def index
    @leads = Agreement.
      leads.
      default_order
  end
end
