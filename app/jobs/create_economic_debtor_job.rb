# frozen_string_literal: true

class CreateEconomicDebtorJob < ApplicationJob
  queue_as :default

  def perform(customer_id)
    customer = Customer.find(customer_id)
    debtor = create_debtor(customer)
    set_debtor_association(customer, debtor)
  end

  private

  def create_debtor(customer)
    economic.create_debtor(customer)
  end

  def economic
    @economic ||= EconomicClient.new
  end

  def set_debtor_association(customer, debtor)
    return unless debtor

    customer.update(:economic_debtor_number => debtor.number)
  end
end
