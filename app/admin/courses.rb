ActiveAdmin.register Course do
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
    column :created_at
    default_actions
  end


end
