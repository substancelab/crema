# frozen_string_literal: true

class BillableItem < ApplicationRecord
  belongs_to :agreement

  scope :uninvoiced, -> { where(:invoiced_at => nil) }
  scope :invoiced, -> { where.not(:invoiced_at => nil) }

  validates :source_key, :uniqueness => {:scope => :source}, :allow_nil => true
end
