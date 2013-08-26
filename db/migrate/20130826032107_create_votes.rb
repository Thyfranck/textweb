class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :link_id
      t.integer :user_id
      t.boolean :up,    :default => 0
      t.boolean :down,  :default => 0

      t.timestamps
    end
  end
end
