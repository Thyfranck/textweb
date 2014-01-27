ActiveAdmin.register Topic do
  menu false
  config.per_page = 50

  filter :course
  filter :name
  filter :created_at

  index do
    selectable_column
    column :id
    column :course
    column :name
    column "Sections" do |t|
      link_to "Sections", admin_school_course_topic_sections_path(t.course.school.id, t.course.friendly_id, t.friendly_id)
    end
    column :created_at
    default_actions
  end

  show do
    attributes_table do
      row :id
      row :course do |topic|
        course = topic.course
        link_to course.name, admin_school_course_path(course.school, course)
      end
      row :name
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs "" do
      f.input :course
      f.input :name
    end
    f.actions
  end

  controller do
    nested_belongs_to :school, :course

    def create
      @school = School.find(params[:school_id])
      @course = Course.find(params[:course_id])
      @topic = @course.topics.new(params[:topic])
      @topic.save
      respond_to do |format|
        format.html{
          if @topic.errors.any?
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
