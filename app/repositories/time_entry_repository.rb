# frozen_string_literal: true

class TimeEntryRepository
  class TimeEntry
    delegate \
      :billable,
      :created_at,
      :id,
      :minutes,
      :locked,
      :locked=,
      :note,
      :project_id,
      :project_name,
      :save,
      :service_id,
      :service_name,
      :to => :mite_resource

    def initialize(mite_resource)
      @mite_resource = mite_resource
    end

    def service_name
      @mite_resource.attributes["service_name"] || "[Unknown service]"
    end

    def serializable_hash
      {
        :id => id,
        :minutes => minutes,
        :service_name => service_name,
      }
    end

    def read_attribute_for_serialization(attribute)
      send(attribute)
    end

    private

    attr_reader :mite_resource
  end

  # Returns all billable time entries on the given date
  def billable_during_period(period)
    mite_time_entries(
      :from => period.begin,
      :to => period.end,
      :billable => true,
      :group_by => "project"
    )
  end

  # Returns all billable time entries in the given period, grouped by day and
  # service
  def billable_hours_for_project_per_day(project, period)
    mite_time_entries(
      :billable => true,
      :from => period.begin,
      :group_by => "day,service",
      :project_id => project.mite_reference,
      :to => period.end
    )
  end

  # Returns all time entries on the given date
  def on_date(date)
    mite_time_entries(:at => date)
  end

  private

  def mite
    @mite ||= MiteClient.new
  end

  def mite_time_entries(options)
    mite.time_entries(options).map do |mite_time_entry|
      TimeEntry.new(mite_time_entry)
    end
  end
end
