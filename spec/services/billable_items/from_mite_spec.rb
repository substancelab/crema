# frozen_string_literal: true

require "rails_helper"

RSpec.describe BillableItems::FromMite do
  subject(:service) { described_class.new(agreement, period) }

  let(:agreement) { create(:agreement, :mite_reference => 12_345) }
  let(:period) { (30.days.ago.to_date)..(Time.zone.today) }

  let(:time_entry) do
    instance_double(
      TimeEntryRepository::TimeEntry,
      :source_key => "42",
      :service_name => "Development",
      :created_at => 1.week.ago,
      :minutes => 120
    )
  end

  let(:repository) { instance_double(TimeEntryRepository) }

  before do
    allow(TimeEntryRepository).to receive(:new).and_return(repository)
    allow(repository).to receive(:billable_hours_for_project).with(agreement, period).and_return([time_entry])
  end

  describe "#call" do
    it "creates a BillableItem from the time entry", :aggregate_failures do
      expect { service.call }.to change(BillableItem, :count).by(1)

      item = BillableItem.last
      expect(item.source).to eq("Mite")
      expect(item.source_key).to eq("42")
      expect(item.description).to eq("Development")
      expect(item.unit).to eq("hour")
      expect(item.quantity).to eq(2.0)
      expect(item.agreement).to eq(agreement)
    end

    it "does not duplicate an already-imported entry" do
      create(:billable_item, :agreement => agreement, :source => "Mite", :source_key => "42")

      expect { service.call }.not_to change(BillableItem, :count)
    end

    it "skips entries that have already been invoiced" do
      create(:billable_item,
             :agreement => agreement,
             :source => "Mite",
             :source_key => "42",
             :description => "Old description",
             :invoiced_at => 1.day.ago)

      service.call

      expect(BillableItem.find_by(:source_key => "42").description).to eq("Old description")
    end
  end
end
