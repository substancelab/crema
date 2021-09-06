# frozen_string_literal: true

agreement = Agreement.
  where(:state => Agreement::DEAL).
  find_by_project_name!("Eventzone Development")

last_month = Range.new(
  Time.zone.today.last_month.beginning_of_month,
  Time.zone.today.last_month.end_of_month
)

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
totals = time.billable_hours_for_project_per_service(project, last_month)

lines = totals.map do |total|
  {
    :description => total.service_name,
    :economic_product_number => product_number(total.service_name),
    :quantity => (total.minutes / 60.0).round(1),
    :unit => agreement.unit.to_sym,
  }
end

economic = EconomicClient.new
p economic.create_invoice(
  agreement,
  lines
)
