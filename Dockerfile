# Use the official Ruby image from the Docker Hub
FROM ruby:3.2.0

# Install dependencies for Node.js and PostgreSQL client
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Set the working directory inside the container
WORKDIR /app

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install the gems specified in the Gemfile
RUN bundle install

# Copy the rest of your application code into the container
COPY . .

# Precompile assets (optional, depending on your app needs)
RUN RAILS_ENV=production bundle exec rake assets:precompile

# Expose the port the app runs on
EXPOSE 3002

# Command to run the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
