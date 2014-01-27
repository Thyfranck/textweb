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

        panel "Statistics of #{school.name}" do
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
        panel "Manage #{school.name}" do

          div :style => "padding-left:13px;font-size: 16px;margin-bottom:10px;" do
            link_to "Add Course", "javascript:;", :id => "add-course-btn", :style => "text-decoration:none;"
          end

          render "course_form"

          table :id => "course-list", :class => "index_table index" do
            school.courses.reverse.each_with_index do |course, index|
              tr :class => index.odd? ? "odd" : "even" do
                td do 
                  span link_to "+", "javascript:;", :class => "toggle-list", :style => "text-decoration: none; font-size: 17px;margin-right:5px;"
                  span link_to "#{course.title} (#{course.name})", admin_school_course_path(school), :style => "text-decoration:none;color:#323537"
                  ul :id => "topic-list-of-#{course.id}", :style => "margin:0;padding-left: 18px;list-style-type: none;display:none" do
                    li do
                      span link_to "Add Topic", "javascript:;", :class => "expan-form", :style => "text-decoration:none;"
                      render "topic_form", :course => course
                    end
                    course.topics.reverse.each do |topic|
                      li do
                        span link_to "+", "javascript:;", :class => "toggle-list", :style => "text-decoration: none; font-size: 17px;margin-right:5px;color:#AF3656"
                        span link_to "#{topic.name}", admin_school_course_topic_path(school, course, topic), :style => "text-decoration:none;color:#323537"
                        ul :id => "section-list-of-#{topic.id}", :style => "margin:0;padding-left: 18px;list-style-type: none;display:none" do
                          li do
                            span link_to "Add Section", "javascript:;", :class => "expan-form", :style => "text-decoration:none;"
                            render "section_form", :topic => topic
                          end
                          topic.sections.reverse.each do |section|
                            li do
                              span link_to "+", "javascript:;", :class => "toggle-list", :style => "text-decoration: none; font-size: 17px;margin-right:5px;color:#36AF56"
                              span link_to "#{section.name}", admin_school_course_topic_section_path(school, course, topic, section), :style => "text-decoration:none;color:#323537"
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
