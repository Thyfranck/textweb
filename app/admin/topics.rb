ActiveAdmin.register Topic do
  menu false
  config.per_page = 50

  filter :course
  filter :name
  filter :created_at

  index do
    selectable_column
    column :id
    column :course
    column :name
    column "Sections" do |t|
      link_to "Sections", admin_school_course_topic_sections_path(t.course.school.id, t.course.id, t.id)
    end
    column :created_at
    default_actions
  end

  controller do
    nested_belongs_to :school, :course
  end
end
