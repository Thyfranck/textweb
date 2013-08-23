ActiveAdmin.register Topic do
  config.per_page = 50

  filter :title
  filter :created_at

  index do
    selectable_column
    column :id
    column :course
    column :title
    column :created_at
    default_actions
  end
end
