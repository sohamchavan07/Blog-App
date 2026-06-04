FROM ruby:3.3.1

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client libjemalloc2 libvips imagemagick

# Set working directory
WORKDIR /rails

# Set production environment
ENV RAILS_ENV="production" \
    BUNDLE_WITHOUT="development:test" \
    RAILS_SERVE_STATIC_FILES="true"

# Copy files
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy application code
COPY . .

# Precompile assets
RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile

# Entrypoint prepares the database.
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Start server, forcing the tracking version for solid cache if it got skipped
EXPOSE 3000
CMD bundle exec rails runner "begin; ActiveRecord::Base.connection.execute(\"INSERT INTO schema_migrations (version) VALUES ('20260428131100')\"); rescue; end" && bundle exec rails db:migrate && ./bin/thrust ./bin/rails server -b 0.0.0.0