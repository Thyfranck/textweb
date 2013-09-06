ActiveAdmin.register School do
  config.per_page = 50

  index do
    column :id
    column :name
    column :email_postfix
    column "Courses" do |c|
      link_to "Courses", admin_school_courses_path(c)
    end
    column :created_at
    column :updated_at
  end
end
