# frozen_string_literal: true

class Agreement < ApplicationRecord
  belongs_to :customer
  belongs_to :service

  validates :project_name, :presence => true
end
