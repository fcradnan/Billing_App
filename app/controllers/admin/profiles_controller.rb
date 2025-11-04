module Admin
  class ProfilesController < BaseController
    include ProfileActions
  
    private

    def after_profile_update_path
      admin_dashboard_path
    end
  end
end
