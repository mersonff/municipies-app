FROM ruby:3.1.2

ENV BUNDLER_VERSION='2.3.7'
ENV APP_USER=municipies_app

RUN apt-get update -qq && apt-get install -y vim\
        curl \
        build-essential \
        libpq-dev \
        postgresql-client \
        nodejs

RUN useradd -ms /bin/bash $APP_USER

USER $APP_USER

WORKDIR /app

COPY --chown=$APP_USER Gemfile Gemfile.lock ./
COPY yarn.lock package.json

RUN apt-get install -y yarn && yarn install

RUN bundle exec rake assets:precompile

RUN gem install bundler -v $BUNDLER_VERSION

RUN bundle config build.nokogiri --use-system-libraries

RUN bundle config set --local without 'development test'

RUN bundle install

COPY --chown=$APP_USER . ./

RUN chmod +x entrypoints/docker-entrypoint.sh

ENTRYPOINT ["./entrypoints/docker-entrypoint.sh"]
