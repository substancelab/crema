# frozen_string_literal: true

class CreateAgreements < ActiveRecord::Migration[6.0]
  def change
    create_table :agreements do |t|
      t.belongs_to :customer, :null => false, :foreign_key => true
      t.belongs_to :service, :null => false, :foreign_key => true
      t.string :project_name
      t.decimal :price
      t.string :unit
      t.datetime :ends_at
      t.string :state
      t.string :purchase_order_number

      t.timestamps
    end
  end
end
