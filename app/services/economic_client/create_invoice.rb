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
      invoice.currency = debtor.currency
      invoice.customer = debtor
      invoice.recipient = {
        "address" => debtor.address,
        "city" => debtor.city,
        "country" => debtor.country,
        "cvr" => debtor.corporate_identification_number,
        "name" => debtor.name,
        "zip" => debtor.zip,
        "vatZone" => debtor.vat_zone,
      }
      invoice.payment_terms = debtor.payment_terms
    end

    def build_invoice(debtor)
      invoice = Reconomic::Invoice.new
      invoice.customer = debtor

      assign_values_from_debtor(invoice, debtor)

      invoice.date = Time.zone.now
      invoice.exchange_rate = 100

      invoice
    end

    def build_invoice_line(line, agreement)
      product_number = line[:economic_product_number] || agreement.service.economic_product_number
      quantity = line[:quantity] || 1
      # TODO: Proper object for these? Reconomic::InvoiceLine?
      {
        "description" => line[:description],
        "product" => {"productNumber" => product_number.to_s},
        "quantity" => quantity,
        "unit" => {
          "unitNumber" => unit_handle(line[:unit]).fetch(:number),
        },
        "unitNetPrice" => agreement.price.to_f,
      }
    end

    def create_invoice(agreement, lines)
      invoice = build_invoice(debtor)
      invoice.notes = {
        "heading" => agreement.project_name
      }
      invoice.references = {
        "customerContact" => contact.handle
      } if contact

      lines.each do |line|
        invoice_line = build_invoice_line(line, agreement)
        invoice.lines << invoice_line
      end

      invoice.layout ||= {
        "layoutNumber" => 4
      }

      invoice.save(:session => session)
      invoice
    end

    def find_contact(name)
      return nil if name.blank?

      contacts = session.contacts.find_by_name(name)
      return nil if contacts.empty?
      return contacts.first if contacts.size == 1

      raise ArgumentError, "Found more than 1 contact named #{name.inspect}"
    end

    def find_debtor(customer)
      Reconomic::Customer.retrieve(
        :number => customer.economic_debtor_number,
        :session => session,
      )
    end

    def find_product(service)
      Reconomic::Product.retrieve(:number => service.economic_product_number, :session => session)
    end

    def unit_handle(unit)
      {
        :per_day => {:number => 2},
        :per_hour => {:number => 1},
        :per_month => {:number => 4},
        :per_unit => {:number => 3},
        :per_week => {:number => 3},
      }.fetch(unit)
    end
  end
end
