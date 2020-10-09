# frozen_string_literal: true

class Service < ApplicationRecord
  UNITS = [
    "per_hour",
    "per_day",
    "per_week",
    "per_month",
    "per_unit",
  ].freeze

  validates :name, :presence => true
  validates :price,
            :numericality => {:greater_than_or_equal_to => 0},
            :presence => true
  validates :unit,
            :inclusion => UNITS,
            :presence => true

  def to_s
    name
  end
end
