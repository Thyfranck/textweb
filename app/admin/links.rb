ActiveAdmin.register Link do
  menu false
  config.per_page = 50
  
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
      link.status.blank? ? "N/A" : link.status
    end
    column :created_at
    column "Manage" do |link|
      link_to "#{link.approved? ? "Unapprove" : "Approve"}", approve_admin_link_path(link)
    end
    default_actions
  end

  form do |f|
    f.inputs "" do
      f.input :section
      f.input :user
      f.input :url
      f.input :file
      f.input :description
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :section do |link|
        section = link.section
        topic = section.topic
        course = topic.course
        link_to section.name, admin_school_course_topic_section_path(course.school, course, topic, section)
      end
      row :user
      row :url
      row :file do |link|
        if link.file.present?
          if link.picture?
            image_tag(link.file.url, :height => "100")
          else
            link_to "Download Document", "#{root_url.chop}#{link.file.url}", :target => "_blank"
          end
        end
      end
      row :description
      row :vote
      row :status
      row :created_at
      row :updated_at
    end
  end

  member_action :approve do
    @link = Link.find(params[:id])
    @link.approved? ? @link.unapprove : @link.approve
    redirect_to admin_school_course_topic_section_links_path(@link.section.topic.course.school.id,@link.section.topic.course.id,@link.section.topic.id,@link.section.id), :notice => "Link #{@link.approved? ? "approved" : "unapproved"}"
  end

  controller do
    nested_belongs_to :school, :course, :topic, :section

    def create
      @school = School.find(params[:school_id])
      @course = Course.find(params[:course_id])
      @topic = Topic.find(params[:topic_id])
      @section = Section.find(params[:section_id])
      @user = User.find_by_email("ftcho001@odu.edu")
      @link = @section.links.new(params[:link])
      @link.user_id = @user.present? ? @user.id : User.first.id
      if @link.save
        redirect_to admin_school_path(@school)
      else
        render :action => :new, :layout => false
      end
    end
  end

end
