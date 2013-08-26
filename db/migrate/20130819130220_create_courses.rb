class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.integer :school_id
      t.string :name
      t.string :title
      t.text :description
      t.string :image
      
      t.timestamps
    end
  end
end
