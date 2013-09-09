ActiveAdmin.register Link do
  menu false
  config.per_page = 50
  
  actions :all, :except => [:new, :edit]
  
  action_item only:[:show] do
    @link = Link.find(params[:id])
    link_to "#{@link.approved? ? "Unapprove": "Approve"}", approve_admin_link_path
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
      link_to "#{link.approved? ? "Unapprove" : "Approve"}", approve_admin_link_path(link)
    end
    default_actions
  end

  member_action :approve do
    @link = Link.find(params[:id])
    @link.approved? ? @link.unapprove : @link.approve
    redirect_to admin_school_course_topic_section_links_path(@link.section.topic.course.school.id,@link.section.topic.course.id,@link.section.topic.id,@link.section.id), :notice => "Link #{@link.approved? ? "approved" : "unapproved"}"
  end

  controller do
    nested_belongs_to :school, :course, :topic, :section
  end

end
