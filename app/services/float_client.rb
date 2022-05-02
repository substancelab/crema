# frozen_string_literal: true

class FloatClient
  class Error < RuntimeError; end

  # https://developer.float.com/api_reference.html#Tasks
  module Task
    module Status
      TENTATIVE = 1
      CONFIRMED = 2
      COMPLETE = 3
    end
  end

  include HTTParty

  base_uri "https://api.float.com/v3"
  logger ::Logger.new("httparty.log")

  attr_reader :api_key

  def initialize(api_key = ENV["FLOAT_API_KEY"])
    @api_key = api_key

    @options = {
      :headers => {
        :authorization => "Bearer #{api_key}",
      }
    }
  end

  def active_projects
    projects.select { |project|
      project["active"] == 1
    }
  end

  # Float only returns one instance of a recurring task per query.
  #
  # Pass `expand: :task_days` to have Float calculate and return all instances
  # of a task in the given timeframe. The calculated dates will be returned
  # under the "task_days" key.
  def tasks_in_date_range(
    dates = DateExt.next_month,
    expand: [],
    project_id: nil,
    status: nil
  )
    get(
      "/tasks",
      {
        :query => {
          :expand => expand,
          :project_id => project_id,
          :start_date => dates.first,
          :end_date => dates.last,
          :status => status
        }
      }
    )
  end

  def create_assignment(attributes = {})
    self.class.post(
      "/assignments",
      @options.merge(
        :body => {
          :assignment => attributes
        }.to_json,
        :headers => {
          "X-Requested-With" => "XMLHttpRequest"
        },
      )
    )
  end

  def people
    get(
      "/people",
      :query => {
        :state => "active"
      }
    )
  end

  def project_report(project_id, dates = DateExt.next_month)
    get(
      "/reports/projects",
      :project_id => project_id,
    )
  end

  def projects
    get("/projects")
  end

  private

  # Send a request to Float, returning the response body as a Hash
  def get(path, options = {})
    response = self.class.get(
      path,
      @options.merge(options)
    )
    result = JSON.parse(response.body)

    case response.code
    when 200
      result
    else
      message = [result["name"], ": ", result["message"]].join
      raise Error, message
    end
  end
end
