ActiveAdmin.register Link do

  action_item only:[:show] do
    link_to "Approve", approve_admin_link_path
  end

  member_action :approve do
    @link = Link.find(params[:id])
    @link.update_attribute(:approved, true)
    @link_creator = @link.creator
    @link_creator.update_attribute(:point, @link_creator.point + User::POINT[:link])
    redirect_to admin_link_path(@link)
  end

  form do |f|
      f.inputs "Details" do
        f.input :topic
        f.input :url
        f.input :description
      end
      f.actions
    end
  
end