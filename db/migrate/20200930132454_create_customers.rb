# frozen_string_literal: true

class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      t.string :company_name
      t.string :tax_id
      t.string :tax_region
      t.string :invoice_email
      t.text :address
      t.string :phone

      t.timestamps
    end
  end
end
