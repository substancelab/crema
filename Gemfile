# frozen_string_literal: true

source "https://rubygems.org"

ruby "3.0.2"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "rails"

gem "bootsnap", ">= 1.4.4", :require => false

# Database
gem "postgresql"
gem "redis-session-store"

# App serving
gem "puma"

gem "rails-i18n"

# Authentication
gem "omniauth-google-oauth2"

# Background processing
gem "sidekiq"

# Frontend
gem "simple_form"
gem "slim-rails"
gem "stimulus_reflex"
gem "turbolinks"
gem "view_component"
gem "webpacker"

# Assets management
gem "uglifier"

# Third-party services
gem "httparty"
gem "mite-rb"
gem "reconomic", :github => "substancelab/reconomic"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger
  # console
  gem "byebug", :platforms => [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem "capybara", ">= 3.26"
  gem "selenium-webdriver"

  gem "dotenv-rails"

  gem "factory_bot_rails"
  gem "rspec-rails", ">= 4.0.0.beta2"
  gem "shoulda-matchers"

  gem "rubocop"
  gem "rubocop-performance"
  gem "rubocop-rails", :require => false
  gem "rubocop-rspec", :require => false
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere
  # in the code.
  gem "listen"
  gem "web-console", ">= 4.1.0"

  # Run stuff automatically
  gem "guard"
  gem "guard-livereload"
  gem "guard-rspec"
  gem "guard-rubocop"

  # Display performance information such as SQL time and flame graphs for each
  # request in your browser. Can be configured to work on production as well
  # see:
  # https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem "rack-mini-profiler"
end

group :test do
  gem "database_cleaner-active_record", :require => false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", :platforms => [:mingw, :mswin, :x64_mingw, :jruby]
