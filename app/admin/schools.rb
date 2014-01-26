ActiveAdmin.register School do
  config.per_page = 50

  actions :all, :except => [:edit, :destroy]

  index do
    column :id
    column :name
    column :email_postfix
    column "Courses" do |c|
      link_to "Courses", admin_school_courses_path(c)
    end
    column :created_at
    column :updated_at
    default_actions
  end

  show do |school|
    columns do
      column do
        attributes_table do
          row :id
          row :name
          row :email_postfix
          row :created_at
          row :updated_at
        end

        panel "Statistics" do
          topics = Topic.where(:course_id => school.course_ids)
          sections = Section.where(:topic_id => topics.map(&:id))
          links = Link.where(:section_id => sections.map(&:id))
          ul do
            li "Total Courses : #{school.courses.count}"
            li "Total Topics : #{topics.count}"
            li "Total Sections : #{sections.count}"
            li "Total Links : #{links.count}"
            li "Total Moderators : #{Moderator.where(:course_id => school.course_ids).count}"
          end
        end
      end
      column :span => 2 do
        panel "Manage School" do

          div :style => "padding-left:13px;font-size: 16px;margin-bottom:10px;" do
            link_to "Add Course", "javascript:;", :id => "add-course-btn", :style => "text-decoration:none;"
          end

          render "course_form"

          table :class => "index_table index" do
            school.courses.reverse.each_with_index do |course, index|
              tr :class => index.odd? ? "odd" : "even" do
                td do 
                  span link_to "+", "javascript:;", :style => "text-decoration: none; font-size: 17px;"
                  span "#{course.title} (#{course.name})"
                end
              end
            end
          end
        end
      end
    end
  end
end
