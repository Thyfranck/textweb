ActiveAdmin.register Course do
  menu false
  config.per_page = 50

  filter :school
  filter :name
  filter :title
  filter :created_at

  form do |f|
    f.inputs "" do
      f.input :school
      f.input :name
      f.input :title
      f.input :description
      f.input :image
    end
    f.actions
  end
  
  index do
    selectable_column
    column :id
    column :school
    column :name
    column :title
    column "Topics" do |c|
      link_to "Topics", admin_school_course_topics_path(c.school.id, c.friendly_id)
    end
    column "Moderators" do |c|
      link_to "Admins", admin_school_course_moderators_path(c.school.id, c.id)
    end
    column :created_at
    default_actions
  end

  controller do
    nested_belongs_to :school
  end

end
