ActiveAdmin.register User do
  config.per_page = 50

  actions :all, :except => [:new, :edit]

  filter :first_name
  filter :last_name
  filter :email
  
  index do
    selectable_column
    column :id
    column :first_name
    column :last_name
    column :email
    column :activation_state
    column :created_at
    column "Manage" do |user|
      link_to "Login", login_admin_user_path(user), :target => "_blank"
    end
    default_actions
  end

  member_action :login do
    @user = User.find(params[:id])
    auto_login @user
    redirect_to @user
  end
end
