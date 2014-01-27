ActiveAdmin.register Section do
  menu false
  config.per_page = 50

  filter :topic
  filter :name
  filter :created_at

  index do
    selectable_column
    column :id
    column :topic
    column :name
    column "Links" do |s|
      link_to "Links", admin_school_course_topic_section_links_path(s.topic.course.school.id,s.topic.course.friendly_id,s.topic.friendly_id,s.friendly_id)
    end
    column :created_at
    default_actions
  end

  show do
    attributes_table do
      row :id
      row :topic do |section|
        topic = section.topic
        course = topic.course
        link_to topic.name, admin_school_course_topic_path(course.school, course, topic)
      end
      row :name
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs "" do
      f.input :topic
      f.input :name
    end
    f.actions
  end

  controller do
    nested_belongs_to :school, :course, :topic

    def create
      @school = School.find(params[:school_id])
      @course = Course.find(params[:course_id])
      @topic = Topic.find(params[:topic_id])
      @section = @topic.sections.new(params[:section])
      @section.save
      respond_to do |format|
        format.html{
          if @section.errors.any?
            render :action => :new, :layout => false
          else
            redirect_to admin_school_path(@school)
          end
        }
        format.js
      end
    end
  end
end
