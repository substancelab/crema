# frozen_string_literal: true

class AddEconomicDebtorNumber < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :economic_debtor_number, :integer
  end
end
