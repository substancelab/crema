# frozen_string_literal: true

class MiteClient
  class << self
    def mite_date(date)
      date.strftime("%Y-%m-%d")
    end
  end

  def find_customer_by_name(name)
    customers.find { |customer| customer.name.casecmp(name.downcase).zero? }
  end

  def find_project_by_id(id)
    projects.find { |project| project.id.to_s == id.to_s }
  end

  def find_project_by_name(name)
    projects.find { |project| project.name.casecmp(name.downcase).zero? }
  end

  def time_entries(options = {})
    configure_mite
    Mite::TimeEntry.all(:params => options)
  end

  def projects
    @projects || fetch_all_from_mite
  end

  private

  def configure_mite
    return if Mite.account.present?

    Mite::Base.logger = Logger.new(Rails.root.join("log/mite.log"))

    Mite.account = ENV["MITE_ACCOUNT"]
    Mite.key = ENV["MITE_KEY"]
    Mite.user_agent = "SubstanceLab/Crema/1.0"
    Mite.validate!
  end

  def fetch_all_from_mite
    configure_mite
    Mite::Project.all
  end

  def customers
    configure_mite
    @customers ||= Mite::Customer.all
  end
end
