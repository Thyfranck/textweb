class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.integer :course_id
      t.string :url
      t.text :description
      t.references :creator, polymorphic: true
      t.integer :plus_count
      t.integer :minus_count
      t.boolean :approved
      

      t.timestamps
    end
  end
end
