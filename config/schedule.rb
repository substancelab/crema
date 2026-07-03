# frozen_string_literal: true

every 1.day do
  runner "script/billable_items/import_all.rb"
end
