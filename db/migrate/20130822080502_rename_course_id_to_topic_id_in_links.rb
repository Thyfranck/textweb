class RenameCourseIdToTopicIdInLinks < ActiveRecord::Migration
  def change
    rename_column :links, :course_id, :topic_id
  end
end
