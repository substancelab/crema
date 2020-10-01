# frozen_string_literal: true

class AgreementsEndAtADate < ActiveRecord::Migration[6.0]
  def down
    change_column :agreements, :ends_on, :datetime
    rename_column :agreements, :ends_on, :ends_at
  end

  def up
    rename_column :agreements, :ends_at, :ends_on
    change_column :agreements, :ends_on, :date
  end
end
