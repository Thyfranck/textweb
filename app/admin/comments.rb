ActiveAdmin.register Comment, :as => "PostComment" do
  config.per_page = 50

  filter :link
  filter :user
  filter :content
  filter :status
  filter :created_at

  index do
    selectable_column
    column :id
    column :link
    column :user
    column :content
    column :status
    column :created_at
    default_actions
  end
end