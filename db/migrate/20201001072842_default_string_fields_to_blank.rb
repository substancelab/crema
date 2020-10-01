# frozen_string_literal: true

class DefaultStringFieldsToBlank < ActiveRecord::Migration[6.0]
  def change
    change_column_default :agreements, :purchase_order_number, :from => nil, :to => ""
    change_column_default :agreements, :state, :from => nil, :to => ""
    change_column_default :agreements, :unit, :from => nil, :to => ""

    change_column_default :customers, :address, :from => nil, :to => ""
    change_column_default :customers, :invoice_email, :from => nil, :to => ""
    change_column_default :customers, :phone, :from => nil, :to => ""
    change_column_default :customers, :tax_id, :from => nil, :to => ""
    change_column_default :customers, :tax_region, :from => nil, :to => ""
  end
end
