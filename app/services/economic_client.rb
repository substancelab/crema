# frozen_string_literal: true

class EconomicClient
  # See https://secure.e-conomic.com/sales/setup/payment-terms
  PAYMENT_TERMS::NET_15 = 3

  attr_reader :economic

  def connect
    session.connect_with_token(
      ENV.fetch("ECONOMIC_APP_SECRET_TOKEN"),
      ENV.fetch("ECONOMIC_GRANT_TOKEN")
    )
  end

  def create_debtor(customer)
    connect
    debtor = session.debtors.build

    debtor.ci_number = customer.tax_id
    debtor.email = customer.invoice_email
    debtor.name = customer.company_name

    debtor.is_accessible = true
    debtor.currency_handle = currency_handle(customer)

    debtor.number = session.debtors.next_available_number

    debtor.debtor_group_handle = debtor_group_handle(customer)

    debtor.vat_zone = vat_zone(customer)

    debtor.term_of_payment_handle = payment_terms_handle(customer)

    debtor.save
  end

  def session
    @session ||= Economic::Session.new
  end

  def invoices_for_customer(customer)
    connect
    debtor = session.debtors.find(:number => customer.economic_debtor_number)
    debtor.invoices || []
  end

  private

  def currency_handle(_customer)
    {:code => "DKK"}
  end

  def debtor_group_handle(customer)
    debtor_group_number = {
      "DK" => 1,
      "EU" => 2,
      "Outside EU" => 3,
    }.fetch(customer.tax_region)

    {:number => debtor_group_number}
  end

  def payment_terms_handle(_customer)
    {:id => PAYMENT_TERMS::NET_15}
  end

  # HomeCountry, EU, Abroad
  def vat_zone(_customer)
    "HomeCountry"
  end
end
