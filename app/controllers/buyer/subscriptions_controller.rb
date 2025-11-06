module Buyer
  class SubscriptionsController < BaseController
    def new
      authorize Subscription
      @plans = Plan.includes(:features)
    end

    def index
      @subscriptions = current_user.subscriptions.includes(:plan).where(status: "active")
    end

    def create
      authorize Subscription
      plan = Plan.find(params[:plan_id])

      current_user.subscribe_to(plan)
      redirect_to buyer_dashboard_path, notice: "Subscribed to #{plan.name}"
    end

    def cancel
      subscription = current_user.subscriptions.find(params[:id])
      subscription.cancel_subscription
      redirect_to buyer_dashboard_path, notice: "Subscription cancelled successfully."
    end
  end
end
