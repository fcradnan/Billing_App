class AdminUser < User
  def charge_monthly_fee(subscription)
    transaction = Transaction.create!(
      buyer: subscription.buyer,
      subscription: subscription,
      amount: subscription.plan.monthly_fee,
      transaction_date: Date.today,
      transaction_type: :monthly_fee,
    )

    BillMailer.subscription_invoice(transaction).deliver_later
  end

  def calculate_overuse(subscription)
    subscription.usages.sum do |usage|
      if usage.units_used > usage.feature.max_unit_limit
        extra_units = usage.units_used - usage.feature.max_unit_limit
        extra_units * usage.feature.unit_price
      else
        0
      end
    end
  end

  def charge_overusage(subscription)
    over_amount = calculate_overuse(subscription)
    return if over_amount.zero?

    transaction = Transaction.create!(
      buyer: subscription.buyer,
      subscription: subscription,
      amount: over_amount,
      transaction_date: Date.today,
      transaction_type: :over_usage,
    )
    BillMailer.subscription_invoice(transaction).deliver_later
  end

  def usage_add(subscription, feature, units)
    Usage.create!(
      subscription: subscription,
      feature: feature,
      units_used: units,
      usage_date: Date.today,
    )
  end

  def run_billing_cycle
    today = Date.current

    Subscription.active.includes(:buyer, :plan).find_each do |subscription|
      if today >= subscription.end_date
        charge_monthly_fee(subscription)
        charge_overusage(subscription)

        subscription.update!(start_date: today, end_date: today + 30.days)
      end
    end
  end
end
