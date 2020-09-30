# frozen_string_literal: true

require "rails_helper"

RSpec.describe Customer, :type => :model do
  it { should validate_presence_of(:company_name) }
  it { should validate_presence_of(:tax_region) }
end
