class OveruseCalculator
  def initialize(subscription)
    @subscription = subscription
  end

  def calculate
    @subscription.usages.sum do |usage|
      if usage.units_used > usage.feature.max_unit_limit
        extra_units = usage.units_used - usage.feature.max_unit_limit
        extra_units * usage.feature.unit_price
      else
        0
      end
    end
  end
end
