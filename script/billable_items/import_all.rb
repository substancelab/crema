# frozen_string_literal: true

# Imports billable items from Mite and Float for all active agreements.
# Run daily via Heroku Scheduler:
#   rails runner script/billable_items/import_all.rb

period = (Time.zone.today - 60.days)..Time.zone.today

agreements = Agreement.where(:state => Agreement::DEAL).where.not(
  :mite_reference => nil
).or(
  Agreement.where(:state => Agreement::DEAL).where.not(:float_project_id => nil)
)

p agreements

agreements.each do |agreement|
  print "#{agreement.project_name}: "

  if agreement.mite_reference
    p "#{agreement.project_name} (Mite)"

    BillableItems::FromMite.new(agreement, period).call
  end

  if agreement.float_project_id
    p "#{agreement.project_name} (Float)"
    BillableItems::FromFloat.new(agreement, period).call
  end

  puts agreement.billable_items.uninvoiced.count
end
