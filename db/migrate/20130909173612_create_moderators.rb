class CreateModerators < ActiveRecord::Migration
  def change
    create_table :moderators do |t|
      t.integer :user_id
      t.integer :course_id
      t.string :status

      t.timestamps
    end
  end
end
