# frozen_string_literal: true

class Agreement < ApplicationRecord
  DEAL = "deal"
  DONE = "done"
  LEAD = "lead"
  STATES = [LEAD, DEAL, DONE].freeze

  belongs_to :customer
  belongs_to :service

  validates :discount_percentage, :numericality => {
    :allow_nil => true,
    :greater_than_or_equal_to => 0,
    :less_than_or_equal_to => 100,
    :only_integer => true,
  }
  validates :project_name, :presence => true
  validates :state, :inclusion => {:in => STATES}

  class << self
    def default_order
      order(:project_name)
    end

    def leads
      where(:state => LEAD)
    end
  end

  def to_s
    project_name
  end
end
