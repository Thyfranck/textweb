ActiveAdmin.register Section do
  config.per_page = 50

  filter :topic
  filter :name
  filter :created_at

  index do
    selectable_column
    column :id
    column :topic
    column :name
    column :created_at
    default_actions
  end
end
