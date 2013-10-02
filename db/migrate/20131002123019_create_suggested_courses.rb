class CreateSuggestedCourses < ActiveRecord::Migration
  def change
    create_table :suggested_courses do |t|
      t.integer :user_id
      t.string :name
      t.string :title

      t.timestamps
    end
  end
end
