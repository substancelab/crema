# frozen_string_literal: true

module Economic
  class DebtorsController < ApplicationController
    def create
      customer = Customer.find(params[:customer_id])
      economic = EconomicClient.new
      debtor = economic.create_debtor(customer)

      if debtor
        customer.update_column(:economic_debtor_number, debtor[:number])
      end

      redirect_to(customer)
    end
  end
end
