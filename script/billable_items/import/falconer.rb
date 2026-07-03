# frozen_string_literal: true

agreement = Agreement.
  where(:state => Agreement::DEAL).
  find_by!(:project_name => "Falconer")

last_month = Range.new(
  Date.today.last_month.beginning_of_month - 1.month,
  Date.today.last_month.end_of_month
)

float = FloatClient.new
float_project_id = 1_403_525
tasks = float.tasks_in_date_range(
  last_month,
  :expand => :task_days,
  :project_id => float_project_id
)

# repeat_state (integer, optional):
#  repeat_state: 0 = No repeat, 1 = Weekly, 2 = Monthly, 3 = Every 2 Weeks ,

hours_per_day = 8

tasks.each do |task|
  p "-" * 20
  p task.values_at("task_id", "project_id", "start_date", "hours", "repeat_state", "repeat_start_date",
                   "repeat_end_date")
  hours = task.fetch("hours")
  task.fetch("task_days", []).each do |day|
    source = "Float"
    source_key = task.fetch("task_id")
    next if BillableItem.exists?(:source => source, :source_key => source_key)

    days = hours.to_f / hours_per_day
    p [day, hours, days]
    BillableItem.create!(
      :agreement => agreement,
      :occurred_at => Date.parse(day).at_noon,
      :quantity => days,
      :source => source,
      :source_key => source_key,
      :unit => "day"
    )

    # TODO: Mark the task as completed?
  end
end
