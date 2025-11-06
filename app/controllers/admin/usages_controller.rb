module Admin
  class UsagesController < BaseController
    def new
      authorize Usage
      @usage = Usage.new
      @buyers = BuyerUser.joins(:subscriptions)
                         .where(subscriptions: { status: "active" })
                         .distinct
      @features = []
    end

    def create
      authorize Usage
      buyer = BuyerUser.find(usage_params[:buyer_id])
      subscription = buyer.subscriptions.find_by(plan_id: usage_params[:plan_id], status: "active")

      if subscription.nil?
        redirect_to new_admin_usage_path, alert: "This buyer has no active subscription." and return
      end

      @usage = Usage.new(
        subscription_id: subscription.id,
        feature_id: usage_params[:feature_id],
        units_used: usage_params[:units_used],
        usage_date: Date.today
      )

      if @usage.save
        redirect_to admin_dashboard_path, notice: "Usage added successfully for #{buyer.name}."
      else
        @buyers = BuyerUser.joins(:subscriptions)
                           .where(subscriptions: { status: "active" })
                           .distinct
        @features = []
        render :new
      end
    end

    def plans_for_buyer
      buyer = BuyerUser.find(params[:buyer_id])
      plans = Plan.joins(:subscriptions)
                .where(subscriptions: { user_id: buyer.id, status: "active" })
                  .distinct
      render json: plans.select(:id, :name)
    end

    def features_for_plan
      plan = Plan.find(params[:plan_id])
      render json: plan.features.select(:id, :name)
    end

    private

    def usage_params
      params.require(:usage).permit(:buyer_id, :plan_id, :feature_id, :units_used)
    end
  end
end
