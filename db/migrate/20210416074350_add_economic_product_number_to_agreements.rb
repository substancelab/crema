# frozen_string_literal: true

class AddEconomicProductNumberToAgreements < ActiveRecord::Migration[6.1]
  def change
    add_column :services, :economic_product_number, :integer
  end
end
