ActiveAdmin.register Course do
  menu false
  config.per_page = 50

  filter :school
  filter :name
  filter :title
  filter :created_at
  
  index do
    selectable_column
    column :id
    column :school
    column :name
    column :title
    column :description do |course|
      course.description.truncate(40) if course.description.present?
    end
    column "Topics" do |c|
      link_to "Topics", admin_school_course_topics_path(c.school.id, c.id)
    end
    column :created_at
    default_actions
  end

  controller do
    nested_belongs_to :school
  end

end
