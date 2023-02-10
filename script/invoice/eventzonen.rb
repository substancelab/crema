# frozen_string_literal: true

require_relative "collector"

agreement = Agreement.
  where(:state => Agreement::DEAL).
  find_by_project_name!("Eventzone Development")

collector = Collector.new
period = collector.billable_period(agreement)
p period

def product_number(service)
  {
    "Application development" => 1,
    "Application setup" => 1,
    "Code review" => 7,
    "Deployment" => 8,
    "Design implementation" => 1,
    "Performance optimization" => 1,
    "Quality assurance" => 7,
    "Project management" => 7,
    "Server management" => 8,
    "Support" => 7,
  }.fetch(service)
end

project = OpenStruct.new(
  :mite_reference => 227_334
)

time = TimeEntryRepository.new
totals = time.billable_hours_for_project_per_service(project, period)

services_rendered = collector.services_rendered_from_mite(agreement, totals)
p services_rendered

lines = services_rendered.map do |service_name, quantity|
  {
    :description => service_name,
    :economic_product_number => product_number(service_name),
    :quantity => quantity.round(1),
    :unit => agreement.unit.to_sym,
  }
end
p lines

economic = EconomicClient.new
p economic.create_invoice(
  agreement,
  lines
)
