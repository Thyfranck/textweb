ActiveAdmin.register Topic do
  config.per_page = 50

  filter :course
  filter :name
  filter :created_at

  index do
    selectable_column
    column :id
    column :course
    column :name
    column :created_at
    default_actions
  end
end
