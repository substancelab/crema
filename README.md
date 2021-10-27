# YourAppName

## System dependencies

* Ruby 3.0 (see `Gemfile`)
* PostgreSQL 11.x (and `libpq-dev` or equivalent)
* Node 11.x <https://nodejs.org/en/download/package-manager/>
* Yarn 1.x <https://yarnpkg.com/en/docs/install#linux-tab>
* Redis (for background jobs)

## Set up the application

1. `cp config/database.yml.example config/database.yml # edit as necessary`
2. `bin/setup`

## Configuration

The following environment variables are expected to be configured by the environment, not via .env files:

* `DOMAIN`: Domain name that the application is being served at.
* `GOOGLE_OAUTH_CLIENT_ID`:
* `GOOGLE_OAUTH_SECRET`:
* `MITE_ACCOUNT`: Credentials for connecting to Mite.
* `MITE_KEY`: Credentials for connecting to Mite.
* `PORT`: The port Puma listens on (defaults to `3000`).
* `RAILS_ENV`: The environment to run the application in (defaults to `development`).
* `RAILS_LOG_TO_STDOUT`: Set this to anything to log to STDOUT instead of a file.
* `RAILS_MASTER_KEY`: Used to encrypt secrets in `config/secrets.yml.enc`.
* `RAILS_MAX_THREADS`: How many threads to run per process (defaults to `5`).
* `RAILS_SERVE_STATIC_FILES`: Set this to let Rails/Puma serve static files. Usually nginx or Apache fronting the application handles this, but if you're only running an application server like Puma, this needs to be set (to any value).
* `REDIS_CACHE_TLS_URL`: Connection string for the Redis server to use for cache store.
* `REDIS_SESSIONS_TLS_URL`: Connection string for the Redis server to use for session store.
* `SMTP_ADDRESS`: Address/hostname of the server to send emails via.
* `SMTP_PASSWORD`: Password for sending emails.
* `SMTP_USERNAME`: Username for sending emails.
