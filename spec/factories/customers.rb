# frozen_string_literal: true

FactoryBot.define do
  factory :customer do
    company_name { "MyString" }
    tax_id { "MyString" }
    tax_region { "DK" }
    invoice_email { "MyString" }
    address { "MyText" }
    phone { "MyString" }
  end
end
