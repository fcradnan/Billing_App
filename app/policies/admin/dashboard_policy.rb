# app/policies/admin/dashboard_policy.rb
module Admin
  class DashboardPolicy < ApplicationPolicy
    def index?
      admin?
    end
  end
end
