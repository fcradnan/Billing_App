
class SubscriptionService
  def initialize(buyer, plan)
    @buyer = buyer
    @plan = plan
  end

  def subscribe
    subscription = @buyer.subscriptions.create!(
      plan: @plan,
      status: :active,
      start_date: Date.today,
      end_date: Date.today + 30.days
    )

   
    Transaction.create!(
      buyer: @buyer,
      subscription: subscription,
      amount: @plan.monthly_fee,
      transaction_date: Date.today,
      transaction_type: :monthly_fee
    )

    BillMailer.subscription_invoice(subscription.transactions.last).deliver_later
    subscription
  end
end
