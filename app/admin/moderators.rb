ActiveAdmin.register Moderator do
  menu false
  config.per_page = 50

  index do
    selectable_column
    column :id
    column :user
    column :course
    column :status
    column :created_at
    column :updated_at
    default_actions
  end

  controller do
    nested_belongs_to :school, :course
  end
end
