# frozen_string_literal: true

class Agreement < ApplicationRecord
  DEAL = "deal"
  DONE = "done"
  LEAD = "lead"
  STATES = [LEAD, DEAL, DONE].freeze

  belongs_to :customer
  belongs_to :service

  validates :project_name, :presence => true
  validates :state, :inclusion => {:in => STATES}

  def to_s
    project_name
  end
end
