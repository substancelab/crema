# frozen_string_literal: true

class CreateServices < ActiveRecord::Migration[6.0]
  def change
    create_table :services do |t|
      t.string :name
      t.string :unit
      t.decimal :price

      t.timestamps
    end
  end
end
