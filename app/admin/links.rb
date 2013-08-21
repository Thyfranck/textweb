ActiveAdmin.register Link do
actions :index
  controller do
    # This code is evaluated within the controller class

    def create
      # override the action here
      link = current_admin_user.links.new(params[:link])
      link.approved = true
      link.save!
      redirect_to admin_links_path
    end
  end

  form do |f|
    f.inputs "Details" do
      f.input :course
      f.input :url
      f.input :description
      f.input :approved
    end
    f.actions
  end
  
end
