class AddPointsToUser < ActiveRecord::Migration
  def change
    add_column :users, :point, :integer, :default => 0
  end
end
