# frozen_string_literal: true

require_relative "boot"

require "rails/all"
require "view_component/engine"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Crema
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    # TODO: 6.1
    config.load_defaults "6.0"

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # By opting-out from `add_autoload_paths_to_load_path` you optimize
    # $LOAD_PATH lookups (less directories to check), and save Bootsnap work and
    # memory consumption, since it does not need to build an index for these
    # directories.
    config.add_autoload_paths_to_load_path = false
  end
end
