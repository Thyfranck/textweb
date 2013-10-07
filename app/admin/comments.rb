ActiveAdmin.register Comment, :as => "CommentsToLink" do
  menu :parent => "Comments"
  
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
    column :created_at
    default_actions
  end
end