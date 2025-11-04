module Admin
  class PlanFeaturesController < BaseController
    before_action :set_plan

    def create
      feature = Feature.find(params[:feature_id])
      @plan.plan_features.find_or_create_by(feature: feature)
      redirect_to admin_plan_path(@plan), notice: "Feature added successfully."
    end

    def destroy
      @plan.plan_features.find(params[:id]).destroy
      redirect_to admin_plan_path(@plan), notice: "Feature removed successfully."
    end

    private

    def set_plan
      @plan = Plan.find(params[:plan_id])
    end
  end
end
