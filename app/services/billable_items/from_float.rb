# frozen_string_literal: true

module BillableItems
  class FromFloat
    HOURS_PER_DAY = 8.0

    def initialize(agreement, period)
      @agreement = agreement
      @period = period
    end

    def call
      tasks.each do |task|
        hours = task.fetch("hours").to_f
        task_id = task.fetch("task_id")

        task.fetch("task_days", []).each do |day|
          source_key = "#{task_id}_#{day}"

          item = BillableItem.find_or_initialize_by(
            :source => "Float",
            :source_key => source_key
          )
          next if item.invoiced_at?

          item.update!(
            :agreement => agreement,
            :occurred_at => Date.parse(day).at_noon,
            :quantity => hours / HOURS_PER_DAY,
            :unit => "day"
          )
        end
      end
    end

    private

    attr_reader :agreement, :period

    def tasks
      FloatClient.new.tasks_in_date_range(
        period,
        :expand => :task_days,
        :project_id => agreement.float_project_id,
        :status => FloatClient::Task::Status::CONFIRMED
      )
    end
  end
end
