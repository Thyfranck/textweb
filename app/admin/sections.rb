ActiveAdmin.register Section do
  menu false
  config.per_page = 50

  filter :topic
  filter :name
  filter :created_at

  index do
    selectable_column
    column :id
    column :topic
    column :name
    column "Links" do |s|
      link_to "Links", admin_school_course_topic_section_links_path(s.topic.course.school.id,s.topic.course.id,s.topic.id,s.id)
    end
    column :created_at
    default_actions
  end

  controller do
    nested_belongs_to :school, :course, :topic
  end
end
