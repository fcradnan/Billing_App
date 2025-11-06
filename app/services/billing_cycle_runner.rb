class BillingCycleRunner
  def run
    today = Date.current

    Subscription
      .active.where('end_date <= ?', today).includes(:buyer, :plan).find_each do |subscription|
        billing = BillingService.new(subscription)
        billing.charge_monthly_fee
        billing.charge_overusage
        subscription.update!(start_date: today, end_date: today + 30.days)
    end
  end
end
