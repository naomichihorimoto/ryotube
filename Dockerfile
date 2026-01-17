# Use Ruby latest version
FROM ruby:latest

# Install dependencies
RUN apt-get update -qq && \
    apt-get install -y nodejs postgresql-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install

# Copy entrypoint script
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

# Copy the rest of the application
COPY . .

# Precompile assets (for production)
# RUN bundle exec rails assets:precompile

# Expose port 3000
EXPOSE 3000

# Set entrypoint
ENTRYPOINT ["/usr/bin/entrypoint.sh"]

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
