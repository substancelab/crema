# frozen_string_literal: true

class FloatClient
  class Error < RuntimeError; end

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

  def tasks_in_date_range(project_id, dates = DateExt.next_month)
    get(
      "/tasks",
      {
        :query => {
          :project_id => project_id,
          :start_date => dates.first,
          :end_date => dates.last,
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
