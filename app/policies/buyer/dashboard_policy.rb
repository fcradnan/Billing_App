# app/policies/admin/dashboard_policy.rb
module Buyer
  class DashboardPolicy < ApplicationPolicy
    def index?
      buyer?
    end
  end
end
