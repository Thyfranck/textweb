ActiveAdmin.register Link do |link|
  config.per_page = 50
  
  actions :all, :except => [:new, :edit]
  action_item only:[:show] do
    link_to "Approve", approve_admin_link_path
  end

  index do
    selectable_column
    column :id
    column :section
    column :user
    column :url
    column :description do |link|
      link.description.truncate(40) if link.description.present?
    end
    column :vote
    column :status
    column :created_at
    column "Manage" do |link|
      link_to "Approve", approve_admin_link_path(link)
    end
    default_actions
  end

  member_action :approve do
    @link = Link.find(params[:id])
    @link.update_attribute(:status, Link::STATUS[:approved])
    @msg = "Link approved"
    redirect_to admin_links_path, :notice => @msg
  end
  
end
