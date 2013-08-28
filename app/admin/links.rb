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
    column :status do |link|
      link.status.blank? ? "New" : link.status
    end
    column :created_at
    column "Manage" do |link|
      link_to "Approve", approve_admin_link_path(link) unless link.approved?
    end
    default_actions
  end

  member_action :approve do
    @link = Link.find(params[:id])
    @link.approve
    redirect_to admin_links_path, :notice => "Link approved"
  end
  
end
