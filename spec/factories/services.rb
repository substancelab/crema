# frozen_string_literal: true

FactoryBot.define do
  factory :service do
    name { "Development work" }
    unit { "month" }
    price { 12_345 }
  end
end
