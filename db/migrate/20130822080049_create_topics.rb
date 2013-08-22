class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.integer :course_id
      t.string :title

      t.timestamps
    end
  end
end
