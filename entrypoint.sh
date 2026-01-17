#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid

# If Rails app doesn't exist, create it
if [ ! -f "config/database.yml" ]; then
  echo "Initializing Rails application..."
  gem install rails -v '~> 8.1.2'
  rails new . --database=postgresql --skip-git --force

  # Update database configuration
  cat > config/database.yml <<EOF
default: &default
  adapter: postgresql
  encoding: unicode
  host: <%= ENV['DATABASE_HOST'] || 'db' %>
  username: <%= ENV['DATABASE_USER'] || 'postgres' %>
  password: <%= ENV['DATABASE_PASSWORD'] || 'password' %>
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>

development:
  <<: *default
  database: ryotube_development

test:
  <<: *default
  database: ryotube_test

production:
  <<: *default
  database: ryotube_production
  username: ryotube
  password: <%= ENV['RYOTUBE_DATABASE_PASSWORD'] %>
EOF
fi

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
