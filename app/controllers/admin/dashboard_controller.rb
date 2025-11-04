module Admin
  class DashboardController < BaseController
    def index
      authorize [:admin, :dashboard], :index?

      @total_buyers = BuyerUser.count
      @total_plans = Plan.count
      @total_revenue = Transaction.sum(:amount)
      @active_subscriptions = Subscription.where(status: :active).count
      @cancelled_subscriptions = Subscription.where(status: :canceled).count
    end
  end
end
