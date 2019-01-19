FROM ruby:2.4.5

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/
RUN bundle install

COPY . /usr/src/app

ARG DATABASE_URL

RUN RACK_ENV=production RAILS_ENV=production bundle exec rake assets:precompile assets:clean

EXPOSE 3000
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
