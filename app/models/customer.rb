# frozen_string_literal: true

class Customer < ApplicationRecord
  validates :company_name, :presence => true
  validates :tax_region, :presence => true

  def to_s
    company_name
  end
end
