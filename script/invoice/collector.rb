# frozen_string_literal: true

class Collector
  # Returns the period to generate an invoice for.
  def billable_period(agreement, last_month: Time.zone.today.last_month)
    service_unit = agreement.unit.to_sym

    case service_unit
    when :per_day, :per_hour
      start_date = last_month.beginning_of_month
      end_date = last_month.end_of_month
    when :per_week
      # Start with the first full week where the month starts
      start_date = last_month.beginning_of_month.beginning_of_week + 1.week
      # Include the full week where the month ends
      end_date = last_month.end_of_month.end_of_week
    else
      raise "Unknown service unit #{service_unit.inspect}"
    end

    Range.new(start_date, end_date)
  end

  # Returns a hash with the services rendered in the given tasks
  def services_rendered(agreement, tasks)
    days_per_week = 4
    hours_per_day = 8

    service_name = agreement.service.name
    service_unit = agreement.unit.to_sym

    services_rendered = Hash.new(0)
    tasks.each do |task|
      # p "-" * 20
      # p task.values_at("project_id", "start_date", "hours", "repeat_state", "repeat_start_date", "repeat_end_date")
      hours = task.fetch("hours")
      task.fetch("task_days", []).each do |day|
        p [day, hours]

        days = hours.to_f / hours_per_day
        weeks = days / days_per_week

        case service_unit
        when :per_day
          services_rendered[service_name] += days
        when :per_hour
          services_rendered[service_name] += hours
        when :per_week
          services_rendered[service_name] += weeks
        end
      end
    end

    services_rendered
  end

  # Returns a hash with the services rendered in the given time totals
  def services_rendered_from_mite(_agreement, time_totals)
    services_rendered = Hash.new(0)

    time_totals.map { |total|
      hours = total.minutes / 60.0
      services_rendered[total.service_name] += hours
    }

    services_rendered
  end
end
