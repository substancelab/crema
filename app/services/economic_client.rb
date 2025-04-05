# frozen_string_literal: true

class EconomicClient
  module PaymentTerms
    # See https://secure.e-conomic.com/sales/setup/payment-terms
    NET_15 = 3
  end

  module VatZones
    HOME_COUNTRY = "HomeCountry"
  end

  attr_reader :economic

  def connect
    session.connect_with_token(
      ENV.fetch("ECONOMIC_APP_SECRET_TOKEN"),
      ENV.fetch("ECONOMIC_GRANT_TOKEN")
    )
  end

  # Creates a Debtor in E-conomic with values from customer. Returns the created
  # Economic::Debtor object.
  def create_debtor(customer)
    EconomicClient::CreateDebtor.new(self).call(customer)
  end

  # Creates an Invoice in E-conomic for customer. Returns the created - and
  # unbooked - Economic::CurrentInvoice object.
  def create_invoice(agreement, lines, reference: nil)
    EconomicClient::CreateInvoice.new(self).call(
      agreement,
      lines,
      :reference => reference
    )
  end

  def session
    @session ||= Reconomic::Session.new
  end

  def invoices_for_customer(customer)
    return [] unless session.respond_to?(:debtors)

    connect
    debtor = session.debtors.find(:number => customer.economic_debtor_number)
    debtor.invoices || []
  end
end
