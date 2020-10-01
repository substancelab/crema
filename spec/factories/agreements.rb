# frozen_string_literal: true

FactoryBot.define do
  factory :agreement do
    customer
    service
    project_name { "Awesome Project" }
    price { 9.99 }
    unit { "hour" }
    ends_on { "2020-12-31" }
    state { "active" }
    purchase_order_number { "" }
  end
end
