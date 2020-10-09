# frozen_string_literal: true

require "rails_helper"

RSpec.describe Customer, :type => :model do
  it { should validate_presence_of(:company_name) }

  it { should validate_presence_of(:tax_region) }
  it { should allow_values(*described_class::TAX_REGIONS).for(:tax_region) }
  it { should_not allow_values("", "Nope").for(:tax_region) }
end
