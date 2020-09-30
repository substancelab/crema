# frozen_string_literal: true

FactoryBot.define do
  factory :agreement do
    customer
    service
    project_name { "Awesome Project" }
    price { 9.99 }
    unit { "hour" }
    ends_at { "2020-09-30 22:00:34" }
    state { "active" }
    purchase_order_number { "" }
  end
end
