class BillingService
  def initialize(subscription)
    @subscription = subscription
  end

  def charge_monthly_fee
    transaction = Transaction.create!(
      buyer: @subscription.buyer,
      subscription: @subscription,
      amount: @subscription.plan.monthly_fee,
      transaction_date: Date.today,
      transaction_type: :monthly_fee
    )

    BillMailer.subscription_invoice(transaction).deliver_later
  end

  def charge_overusage
    over_amount = OveruseCalculator.new(@subscription).calculate
    return if over_amount.zero?

    transaction = Transaction.create!(
      buyer: @subscription.buyer,
      subscription: @subscription,
      amount: over_amount,
      transaction_date: Date.today,
      transaction_type: :over_usage
    )

    BillMailer.subscription_invoice(transaction).deliver_later
  end
end
