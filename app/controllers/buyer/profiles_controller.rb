module Buyer
  class ProfilesController < BaseController
    include ProfileActions

    private

    def after_profile_update_path
      buyer_dashboard_path
    end
  end
end
