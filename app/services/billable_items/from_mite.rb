# frozen_string_literal: true

module BillableItems
  class FromMite
    HOURS_PER_MINUTE = 1.0 / 60

    def initialize(agreement, period)
      @agreement = agreement
      @period = period
    end

    def call
      time_entries.each do |entry|
        item = BillableItem.find_or_initialize_by(
          :source => "Mite",
          :source_key => entry.source_key
        )
        next if item.invoiced_at?

        item.update!(
          :agreement => agreement,
          :description => entry.service_name,
          :occurred_at => entry.created_at,
          :quantity => entry.minutes * HOURS_PER_MINUTE,
          :unit => "hour"
        )
      end
    end

    private

    attr_reader :agreement, :period

    def time_entries
      TimeEntryRepository.new.billable_hours_for_project(agreement, period)
    end
  end
end
