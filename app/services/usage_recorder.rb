class UsageRecorder
  def initialize(subscription, feature, units)
    @subscription = subscription
    @feature = feature
    @units = units
  end

  def record
    Usage.create!(
      subscription: @subscription,
      feature: @feature,
      units_used: @units,
      usage_date: Date.today
    )
  end
end
