class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.integer :link_id
      t.integer :user_id
      t.boolean :plus
      t.boolean :minus
      
      t.timestamps
    end
  end
end
