module Buyer
  class TransactionsController < BaseController
    def index
      authorize Transaction
      @buyer = current_user
      @transactions = @buyer.transactions.includes(:subscription).order(created_at: :desc)
    end

    
  end
end
