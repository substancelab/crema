# frozen_string_literal: true

require "rails_helper"

RSpec.describe BillableItems::FromFloat do
  subject(:service) { described_class.new(agreement, period) }

  let(:agreement) { create(:agreement, :float_project_id => 99_999) }
  let(:period) { (60.days.ago.to_date)..(Time.zone.today) }

  let(:tasks) do
    [
      {
        "task_id" => 1001,
        "hours" => 8.0,
        "task_days" => ["2026-06-01", "2026-06-08"],
      },
    ]
  end

  let(:float_client) { instance_double(FloatClient) }

  before do
    allow(FloatClient).to receive(:new).and_return(float_client)
    allow(float_client).to receive(:tasks_in_date_range).and_return(tasks)
  end

  describe "#call" do
    it "creates one BillableItem per task day" do
      expect { service.call }.to change(BillableItem, :count).by(2)
    end

    it "uses a compound source_key of task_id and day" do
      service.call

      expect(BillableItem.pluck(:source_key)).to contain_exactly("1001_2026-06-01", "1001_2026-06-08")
    end

    it "sets quantity as hours / 8" do
      service.call

      expect(BillableItem.first.quantity).to eq(1.0)
    end

    it "does not duplicate an already-imported task day" do
      create(:billable_item, :agreement => agreement, :source => "Float", :source_key => "1001_2026-06-01")

      expect { service.call }.to change(BillableItem, :count).by(1)
    end

    it "skips task days that have already been invoiced" do
      create(:billable_item,
             :agreement => agreement,
             :source => "Float",
             :source_key => "1001_2026-06-01",
             :invoiced_at => 1.day.ago,
             :quantity => 99)

      service.call

      expect(BillableItem.find_by(:source_key => "1001_2026-06-01").quantity).to eq(99)
    end
  end
end
