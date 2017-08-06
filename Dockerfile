FROM ruby:2.4.1

MAINTAINER Ievgen Vigura <zhekavigura@gmail.com>

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs mc locales postgresql-client cmake vim --no-install-recommends

ENV APP_HOME /shopify_test
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

ENV BUNDLE_PATH /box
COPY Gemfile ./
COPY Gemfile.lock ./
RUN bundle check || bundle install --jobs 20 --retry 5

COPY . ./

# Provide dummy data to Rails so it can pre-compile assets.
# RUN bundle exec rake RAILS_ENV=production DATABASE_URL=postgresql://user:pass@127.0.0.1/dbname SECRET_TOKEN=pickasecuretoken assets:precompile

# Expose a volume so that nginx will be able to read in assets in production.
VOLUME ["$APP_HOME/public"]

# Configure an entry point, so we don't need to specify
# "bundle exec" for each of our commands.
ENTRYPOINT ["bundle", "exec"]

# The main command to run when the container starts. Also
# tell the Rails dev server to bind to all interfaces by
# default.
CMD ["./start.sh"]
