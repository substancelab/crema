# frozen_string_literal: true

class EconomicClient
  attr_reader :economic

  def connect
    session.connect_with_token(
      ENV.fetch("ECONOMIC_APP_SECRET_TOKEN"),
      ENV.fetch("ECONOMIC_GRANT_TOKEN")
    )
  end

  def session
    @session ||= Economic::Session.new
  end

  def invoices_for_customer(customer)
    connect
    debtor = session.debtors.find(:number => customer.economic_debtor_number)
    debtor.invoices
  end
end
