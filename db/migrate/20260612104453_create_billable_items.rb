# frozen_string_literal: true

class CreateBillableItems < ActiveRecord::Migration[8.1]
  def change
    create_table :billable_items do |t|
      t.belongs_to :agreement, :null => false, :foreign_key => true
      t.string :description
      t.datetime :occurred_at
      t.string :source
      t.string :source_key
      t.string :unit
      t.decimal :quantity
      t.datetime :invoiced_at
      t.string :invoice_reference
      t.timestamps
    end

    add_index :billable_items, [:source, :source_key], :unique => true
  end
end
