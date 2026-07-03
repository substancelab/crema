# frozen_string_literal: true

require "ostruct"

agreement = Agreement.
  where(:state => Agreement::DEAL).
  find_by!(:project_name => "Eventzone Development")

last_month = Range.new(
  Time.zone.today.last_month.beginning_of_month,
  Time.zone.today.last_month.end_of_month
)

project = OpenStruct.new(
  :mite_reference => 227_334
)

time = TimeEntryRepository.new
items = time.billable_hours_for_project(project, last_month)

items.each do |item|
  $stdout.flush

  source = "Mite"
  source_key = item.source_key
  if BillableItem.exists?(:source => source, :source_key => source_key)
    print "S"
    next
  else
    print "."
    BillableItem.create!(
      :agreement => agreement,
      :description => item.service_name,
      :occurred_at => item.created_at,
      :quantity => 60.0 / item.minutes,
      :source => source,
      :source_key => source_key,
      :unit => "hour"
    )
  end
end
puts

# TODO: Mark time entry as having been invoiced?
