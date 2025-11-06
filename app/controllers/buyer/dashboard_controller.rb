module Buyer
  class DashboardController < BaseController
    def index
      authorize [:buyer, :dashboard], :index?

      @subscriptions_count = current_user.subscriptions.count
      @active_subscriptions_count = current_user.subscriptions.where(status: "active").count
      @transactions_count = current_user.transactions.count
      @total_spent = current_user.transactions.sum(:amount)
    end
  end
end
