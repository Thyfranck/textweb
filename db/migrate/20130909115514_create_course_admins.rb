class CreateCourseAdmins < ActiveRecord::Migration
  def change
    create_table :course_admins do |t|
      t.integer :user_id
      t.integer :course_id
      t.boolean :active

      t.timestamps
    end
  end
end
