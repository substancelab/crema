# frozen_string_literal: true

class AddDiscountPercentageToAgreements < ActiveRecord::Migration[7.1]
  def change
    add_column \
      :agreements,
      :discount_percentage,
      :integer,
      :default => 0,
      :null => false
  end
end
