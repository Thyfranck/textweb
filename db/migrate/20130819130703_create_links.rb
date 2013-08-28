class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.integer :section_id
      t.integer :user_id
      t.string  :url
      t.text    :description
      t.integer :vote,        :default => 0
      t.string  :status

      t.timestamps
    end
  end
end
