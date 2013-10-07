ActiveAdmin.register Reply, :as => "RepliesToComment" do
  menu :parent => "Comments"

  index do
    selectable_column
    column :id
    column :comment
    column :user
    column :content
    column :created_at
    default_actions
  end
end
