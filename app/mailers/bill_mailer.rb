class BillMailer < ApplicationMailer
  def subscription_invoice(transaction)
    @transaction = transaction
    @buyer = transaction.buyer
    @subscription = transaction.subscription
    @plan = @subscription.plan

    mail(
      to: @buyer.email,
      subject: "Bill for your #{@plan.name} subscription (#{transaction.transaction_type.humanize})",
    )
  end
end
