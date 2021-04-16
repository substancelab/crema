# frozen_string_literal: true

require_relative "../economic_client"

class EconomicClient
  class CreateInvoice
    attr_reader \
      :client,
      :session

    def initialize(client)
      @client = client
      @session = client.session
    end

    def call(agreement, lines = [], reference: nil)
      client.connect

      self.contact = find_contact(reference)
      self.debtor = find_debtor(agreement.customer)
      self.product = find_product(agreement.service)

      create_invoice(agreement, lines)
    end

    private

    attr_accessor \
      :contact,
      :debtor,
      :product

    def assign_values_from_debtor(invoice, debtor)
      invoice.currency_handle = debtor.currency_handle
      invoice.debtor_name = debtor.name
      invoice.debtor_address = debtor.address
      invoice.debtor_postal_code = debtor.postal_code
      invoice.debtor_city = debtor.city
      invoice.debtor_country = debtor.country
      invoice.term_of_payment_handle = debtor.term_of_payment_handle
    end

    def build_invoice(debtor)
      invoice = debtor.current_invoices.build

      assign_values_from_debtor(invoice, debtor)

      invoice.date = Time.zone.now
      # invoice.due_date = Time.zone.now + 15 # TODO
      invoice.exchange_rate = 100
      invoice.is_vat_included = true

      invoice
    end

    def build_invoice_line(line, agreement)
      invoice_line = Economic::CurrentInvoiceLine.new
      invoice_line.description = line[:description]
      invoice_line.product_handle = {:number => agreement.service.economic_product_number}
      invoice_line.quantity = line[:quantity] || 1
      invoice_line.unit_handle = unit_handle(line[:unit])
      invoice_line.unit_net_price = agreement.price
      invoice_line
    end

    def create_invoice(agreement, lines)
      invoice = build_invoice(debtor)
      invoice.heading = agreement.project_name
      invoice.your_reference_handle = contact.handle if contact

      lines.each do |line|
        invoice_line = build_invoice_line(line, agreement)
        invoice.lines << invoice_line
      end

      invoice.save
      invoice
    end

    def find_contact(name)
      contacts = session.contacts.find_by_name(name)
      return nil if contacts.empty?
      return contacts.first if contacts.size == 1

      raise ArgumentError, "Found more than 1 contact named #{name.inspect}"
    end

    def find_debtor(customer)
      session.debtors.find(:number => customer.economic_debtor_number)
    end

    def find_product(service)
      session.products.find(:number => service.economic_product_number)
    end

    def unit_handle(unit)
      {
        :per_day => {:number => 2},
        :per_hour => {:number => 1},
        :per_month => {:number => 4},
        :per_unit => {:number => 3},
      }.fetch(unit)
    end
  end
end
