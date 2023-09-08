# frozen_string_literal: true

require_relative "collector"

def last_week_day(dayname, before: Date.today)
  parsed_day = Date.parse(dayname)
  raise ArgumentError, "Couldn't figure out what day #{dayname.inspect} refers to" if parsed_day.blank?

  day_to_find = parsed_day.cwday
  today_index = before.cwday
  day_difference = day_to_find - today_index
  day_difference -= 7 if day_difference >= 0
  (before + day_difference).to_date
end

MITE_TO_ECONOMIC_MAPPINGS = {
  "Development" => "Udviklingsiteration",
}.freeze

agreement = Agreement.
  where(:state => Agreement::DEAL).
  find_by!(:project_name => "BoligZonen")

collector = Collector.new
period = collector.billable_period(agreement)

float = FloatClient.new
float_project_id = 8_441_805
tasks = float.tasks_in_date_range(
  period,
  :expand => :task_days,
  :project_id => float_project_id,
  :status => FloatClient::Task::Status::CONFIRMED
)

if tasks.empty?
  puts "No tasks found for #{period.inspect}"
  exit
else
  puts "Found #{tasks.size} tasks for #{period.inspect}"
end

services_rendered = collector.services_rendered(agreement, tasks)

lines = services_rendered.map do |service_name, quantity|
  start_date = period.first
  month_name = I18n.localize(start_date, :format => "%B", :locale => "da")

  translated_service = MITE_TO_ECONOMIC_MAPPINGS.fetch(service_name)

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
p lines

economic = EconomicClient.new
p economic.create_invoice(
  agreement,
  lines
)
