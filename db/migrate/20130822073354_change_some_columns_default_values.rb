class ChangeSomeColumnsDefaultValues < ActiveRecord::Migration
  def up
    change_column :links, :plus_count, :integer, :default => 0
    change_column :links, :minus_count, :integer, :default => 0
    change_column :links, :approved, :boolean, :default => false
  end

  def down
    change_column :links, :plus_count, :integer
    change_column :links, :minus_count, :integer
    change_column :links, :approved, :boolean
  end
end