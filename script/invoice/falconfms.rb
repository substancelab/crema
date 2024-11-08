# frozen_string_literal: true

last_month = Range.new(
  Date.today.last_month.beginning_of_month,
  Date.today.last_month.end_of_month
)

agreement = Agreement.
  where(:state => Agreement::DEAL).
  where("ends_on IS NULL OR ends_on >= ?", last_month.last).
  find_by!(:project_name => "Folio")
service_unit = agreement.unit.to_sym
p agreement

last_month = Time.zone.today.last_month

case service_unit
when :per_day
  start_date = last_month.beginning_of_month
  end_date = last_month.end_of_month
else
  raise "Unknown service unit #{service_unit.inspect}"
end

period = Range.new(start_date, end_date)

float = FloatClient.new
float_project_id = 9_144_055
tasks = float.tasks_in_date_range(
  period,
  :expand => :task_days,
  :project_id => float_project_id,
  :status => 2 # Not completed, nor tentative
)
p tasks

if tasks.empty?
  puts "No tasks found for #{period.inspect}"
  exit
else
  puts "Found #{tasks.size} tasks for #{period.inspect}"
end

# repeat_state (integer, optional):
#  repeat_state: 0 = No repeat, 1 = Weekly, 2 = Monthly, 3 = Every 2 Weeks ,

days_per_week = 4
hours_per_day = 8

service_name = agreement.service.name

services_rendered = Hash.new(0)
tasks.each do |task|
  # p "-" * 20
  # p task.values_at("project_id", "start_date", "hours", "repeat_state", "repeat_start_date", "repeat_end_date")
  hours = task.fetch("hours")
  task.fetch("task_days", []).each do |day|
    p [day, hours]

    days = hours.to_f / hours_per_day
    weeks = days / days_per_week

    case service_unit
    when :per_day
      services_rendered[service_name] += days
    when :per_hour
      services_rendered[service_name] += hours
    when :per_week
      services_rendered[service_name] += weeks
    end
  end
end

p services_rendered

lines = services_rendered.map do |service_name, quantity|
  start_date = period.first
  month_name = I18n.localize(start_date, :format => "%B", :locale => "da")

  translated_service = {
    "Development" => "Udviklingsiteration",
  }.fetch(service_name, service_name)

  description = [
    translated_service,
    "#{month_name} #{start_date.year}".titlecase,
  ].join("\n")

  {
    :description => description,
    :unit => agreement.unit.to_sym,
    :quantity => quantity,
  }
end

economic = EconomicClient.new
p economic.create_invoice(
  agreement,
  lines
)
