# frozen_string_literal: true

class AddTrackerRefsToAgreements < ActiveRecord::Migration[8.1]
  def change
    add_column :agreements, :mite_reference, :integer
    add_column :agreements, :float_project_id, :integer
  end
end
