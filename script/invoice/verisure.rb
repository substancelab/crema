# frozen_string_literal: true

agreement = Agreement.
  where(:state => Agreement::DEAL).
  find_by_project_name!("Tryghedsskaberen")

economic = EconomicClient.new

next_month = Date.today.next_month
next_month_name = I18n.localize(next_month, :format => "%B", :locale => "da")

description = [
  "Vedligeholdelsesaftale",
  "#{next_month_name} #{next_month.year}".titlecase,
].join("\n")

lines = [
  {
    :description => description,
    :unit => agreement.unit.to_sym,
  }
]
p economic.create_invoice(
  agreement,
  lines,
  :reference => "Steffen Møller Petersen"
)
