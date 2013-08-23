class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.integer :topic_id
      t.string :url
      t.text :description
      t.references :creator, polymorphic: true
      t.integer :plus_count, :default => 0
      t.integer :minus_count, :default => 0
      t.boolean :approved, :default => false
      

      t.timestamps
    end
  end
end
