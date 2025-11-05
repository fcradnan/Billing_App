class BillingCycleRunner
  def run
    today = Date.current

    Subscription.active.includes(:buyer, :plan).find_each do |subscription|
      if today >= subscription.end_date
        billing = BillingService.new(subscription)
        billing.charge_monthly_fee
        billing.charge_overusage

        subscription.update!(start_date: today, end_date: today + 30.days)
      end
    end
  end
end
