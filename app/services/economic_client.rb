# frozen_string_literal: true

class EconomicClient
  class CreateDebtor
    attr_reader \
      :client,
      :session

    def initialize(client)
      @client = client
      @session = client.session
    end

    def call(customer)
      client.connect
      debtor = build_debtor(customer)
      debtor.number = session.debtors.next_available_number
      debtor.save
      debtor
    end

    private

    def assign_default_values(debtor)
      debtor.is_accessible = true
    end

    def assign_values_from_customer(debtor, customer)
      debtor.ci_number = customer.tax_id
      debtor.email = customer.invoice_email
      debtor.name = customer.company_name

      debtor.currency_handle = currency_handle(customer)
      debtor.debtor_group_handle = debtor_group_handle(customer)
      debtor.term_of_payment_handle = payment_terms_handle(customer)
      debtor.vat_zone = vat_zone(customer)
    end

    def build_debtor(customer)
      debtor = session.debtors.build

      assign_default_values(debtor)
      assign_values_from_customer(debtor, customer)

      debtor
    end

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
      {:id => EconomicClient::PaymentTerms::NET_15}
    end

    # HomeCountry, EU, Abroad
    def vat_zone(_customer)
      EconomicClient::VatZones::HOME_COUNTRY
    end
  end

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

  def session
    @session ||= Economic::Session.new
  end

  def invoices_for_customer(customer)
    connect
    debtor = session.debtors.find(:number => customer.economic_debtor_number)
    debtor.invoices || []
  end
end
