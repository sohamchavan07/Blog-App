FROM ruby:3.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Set working directory
WORKDIR /app

# Copy files
COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

# Start server
CMD ["rails", "s", "-b", "0.0.0.0"]
