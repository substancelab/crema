# frozen_string_literal: true

class CreateEconomicDebtorJob < ApplicationJob
  queue_as :default

  def perform(customer_id)
    customer = Customer.find(customer_id)
    economic = EconomicClient.new

    debtor = economic.create_debtor(customer)
    return unless debtor

    customer.update_column(:economic_debtor_number, debtor.number)
  end
end
