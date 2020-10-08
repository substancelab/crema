# frozen_string_literal: true

module Economic
  class DebtorsController < ApplicationController
    def create
      customer = Customer.find(params[:customer_id])
      CreateEconomicDebtorJob.perform_later(customer.id)
      redirect_to(customer)
    end
  end
end
