# frozen_string_literal: true

class EconomicClient
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

    debtor.number = session.debtors.next_available_number

    debtor_group_number = {
      "DK" => 1,
      "EU" => 2,
      "Outside EU" => 3,
    }.fetch(customer.tax_region)

    debtor.debtor_group_handle = {:number => debtor_group_number}
    debtor.ci_number = customer.tax_id
    debtor.is_accessible = true
    debtor.name = customer.company_name
    debtor.email = customer.invoice_email

    debtor.vat_zone = "HomeCountry" # HomeCountry, EU, Abroad
    debtor.currency_handle = {:code => "DKK"}

    # Forfaldsdato
    # Lb. md. 30 dage
    # Løbende uge med start mandag
    # Løbende uge med start mandag
    # 3: Netto 15 dage
    # Netto 30 dage
    debtor.term_of_payment_handle = {:id => 3}
    # debtor.layout_handle = {:id => 16}

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
end
