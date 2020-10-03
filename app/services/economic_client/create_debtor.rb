# frozen_string_literal: true

require_relative "../economic_client"

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
end
