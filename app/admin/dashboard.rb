ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do


    columns do
      column do
        panel "Recent Links" do
          ul do
            Link.order("created_at desc").limit(20).map do |link|
              li link_to(link.description.present? ? link.description.truncate(50) : "No description", admin_school_course_topic_section_link_path(link.section.topic.course.school, link.section.topic.course, link.section.topic, link.section, link))
            end
          end
        end
      end

      column do
        panel "Recent Suggested Courses" do
          ul do
            SuggestedCourse.order("created_at desc").limit(20).map do |course|
              li "#{course.name} | #{course.title}"
            end
          end
        end
      end

      column do
        panel "Site Statistics" do
          ul do
            li "Total Admins : #{AdminUser.count}"
            li "Total Schools : #{School.count}"
            li "Total Courses : #{Course.count}"
            li "Total Topics : #{Topic.count}"
            li "Total Sections : #{Section.count}"
            li "Total Links : #{Link.count}"
            li "Total Comments : #{Comment.count + Reply.count}"
            li "Total Up Votes : #{Vote.where(:up => true).count}"
            li "Total Down Votes : #{Vote.where(:down => true).count}"
            li "Total Users : #{User.count}"
            li "Total Active Users : #{User.where(:activation_state => "active").count}"
            li "Total Moderators : #{Moderator.count}"
          end
        end
      end

      
      column do
        panel "Info" do
          para "Welcome to ActiveAdmin."
        end
      end
    end

  end 
end
