class RemoveMinusFromRates < ActiveRecord::Migration
  def up
    remove_column :rates, :minus
  end

  def down
    add_column :rates, :minus, :boolean
  end
end
