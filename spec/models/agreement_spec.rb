# frozen_string_literal: true

require "rails_helper"

RSpec.describe Agreement, :type => :model do
  it { should belong_to(:customer).required }
  it { should belong_to(:service).required }

  it { should validate_presence_of(:project_name) }

  it { should allow_values(*described_class::STATES).for(:state) }
  it { should_not allow_values("", "what?", "active").for(:state) }
end
