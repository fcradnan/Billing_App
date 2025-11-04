module Buyer
  class BaseController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_buyer!

    private

    def ensure_buyer!
      unless current_user.is_a?(BuyerUser)
        redirect_to admin_dashboard_path
      end
    end
  end
end
