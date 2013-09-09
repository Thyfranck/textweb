ActiveAdmin.register CourseAdmin do

  index do
    selectable_column
    column :id
    column "User" do |ca|
      User.find(ca.user_id).name
    end
    column "Course" do |ca|
      Course.find(ca.course_id).name
    end
    column :created_at
    column :updated_at
    default_actions
  end

  controller do
    def create
      @course_admin = CourseAdmin.new(params[:course_admin])
      if @course_admin.save
        redirect_to admin_course_admin_url(@course_admin)
      else
        if @course_admin.errors.any?
          render :action => :new
        else
          redirect_to admin_course_admins_url, :alert => "This User is already admin of this course"
        end
      end
    end
  end
end
