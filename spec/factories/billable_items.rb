# frozen_string_literal: true

FactoryBot.define do
  factory :billable_item do
    agreement
    description { "Development" }
    occurred_at { Time.zone.now }
    source { "Mite" }
    sequence(:source_key) { |n| "mite-#{n}" }
    unit { "hour" }
    quantity { 1.5 }
  end
end
