# frozen_string_literal: true

require "rails_helper"

RSpec.describe Service, :type => :model do
  it { should validate_presence_of(:name) }

  it { should validate_presence_of(:price) }
  it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }

  it { should validate_presence_of(:unit) }
end
