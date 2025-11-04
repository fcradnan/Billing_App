class BuyerUser < User
  has_many :plans, through: :subscriptions

  has_many :subscriptions, foreign_key: :user_id, dependent: :destroy
  has_many :transactions, foreign_key: :user_id, dependent: :destroy

  has_many :usages, through: :subscriptions

  def active_subscription
    subscriptions.find_by(status: :active)
  end

  def total_billed_amount
    transactions.sum(:amount)
  end

  def subscribe_to(plan)
    subscription = subscriptions.create!(
      plan: plan,
      status: :active,
      start_date: Date.today,
      end_date: Date.today + 30.days
    )

    transaction = Transaction.create!(
      buyer: self,
      subscription: subscription,
      amount: plan.monthly_fee,
      transaction_date: Date.today,
      transaction_type: :monthly_fee
    )

    BillMailer.subscription_invoice(transaction).deliver_later
    subscription
  end

  def usage_report
    usages.includes(:feature).map do |usage|
      {
        feature: usage.feature.name,
        units_used: usage.units_used,
        limit: usage.feature.max_unit_limit,
      }
    end
  end
end
