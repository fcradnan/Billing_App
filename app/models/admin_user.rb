class AdminUser < User
  def run_billing_cycle
    BillingCycleRunner.new.run
  end

  def add_usage(subscription, feature, units)
    UsageRecorder.new(subscription, feature, units).record
  end
end
