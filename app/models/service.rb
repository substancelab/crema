# frozen_string_literal: true

class Service < ApplicationRecord
  validates :name, :presence => true
  validates :price,
            :numericality => {:greater_than_or_equal_to => 0},
            :presence => true
  validates :unit, :presence => true
end
