# frozen_string_literal: true

require "rails_helper"

RSpec.describe BillableItem, :type => :model do
  it { should belong_to(:agreement).required }

  describe "source_key uniqueness" do
    subject { create(:billable_item) }

    it { should validate_uniqueness_of(:source_key).scoped_to(:source).allow_nil }
  end

  describe ".uninvoiced" do
    it "returns items without an invoiced_at" do
      invoiced = create(:billable_item, :invoiced_at => 1.day.ago)
      uninvoiced = create(:billable_item, :invoiced_at => nil)

      expect(described_class.uninvoiced).to contain_exactly(uninvoiced)
      expect(described_class.uninvoiced).not_to include(invoiced)
    end
  end

  describe ".invoiced" do
    it "returns items with an invoiced_at" do
      invoiced = create(:billable_item, :invoiced_at => 1.day.ago)
      create(:billable_item, :invoiced_at => nil)

      expect(described_class.invoiced).to contain_exactly(invoiced)
    end
  end
end
