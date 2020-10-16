# frozen_string_literal: true

class Customer < ApplicationRecord
  TAX_REGIONS = [
    "DK",
    "EU",
    "Outside EU",
  ].freeze

  has_many :agreements, :dependent => :destroy

  validates :company_name, :presence => true
  validates :tax_region, :presence => true, :inclusion => TAX_REGIONS

  def to_s
    company_name
  end
end
