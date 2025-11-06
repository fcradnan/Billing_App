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
    SubscriptionService.new(self, plan).subscribe
  end

  def usage_report
    UsageReport.new(self).generate
  end
end
