ActiveAdmin.register Course do
  menu false
  config.per_page = 50

  filter :school
  filter :name
  filter :title
  filter :created_at

  actions :all, :except => [:new]

  form do |f|
    f.inputs "" do
      f.input :school
      f.input :name
      f.input :title
      f.input :description
      f.input :image
    end
    f.actions
  end
  
  index do
    selectable_column
    column :id
    column :name
    column :title
    column "Topics" do |c|
      link_to "Topics", admin_school_course_topics_path(c.school.id, c.friendly_id)
    end
    column "Moderators" do |c|
      link_to "Moderators", admin_school_course_moderators_path(c.school.id, c.id)
    end
    column :created_at
    default_actions
  end

  controller do
    nested_belongs_to :school

    def create
      @school = School.find(params[:school_id])
      @course = @school.courses.new(params[:course])
      if @course.save
        redirect_to admin_school_path(@school)
      else
        render :action => :new, :layout => false
      end
    end
  end

end
