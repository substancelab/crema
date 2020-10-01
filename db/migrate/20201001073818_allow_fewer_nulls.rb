# frozen_string_literal: true

class AllowFewerNulls < ActiveRecord::Migration[6.0]
  def change
    change_column_null :agreements, :project_name, false
    change_column_null :agreements, :purchase_order_number, false
    change_column_null :agreements, :state, false
    change_column_null :agreements, :unit, false

    change_column_null :customers, :address, false
    change_column_null :customers, :company_name, false
    change_column_null :customers, :invoice_email, false
    change_column_null :customers, :phone, false
    change_column_null :customers, :tax_id, false
    change_column_null :customers, :tax_region, false

    change_column_null :services, :name, false
    change_column_null :services, :unit, false
    change_column_null :services, :price, false
  end
end
