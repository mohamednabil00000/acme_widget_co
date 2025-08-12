FROM ruby:3.2

WORKDIR /myapp

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev && rm -rf /var/lib/apt/lists/*

COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN gem update --system && gem install bundler
# Install Ruby dependencies
RUN bundle install

# Copy the rest of the application
COPY . /myapp

RUN mkdir -p /mpapp/health_check_files/pids

COPY /docker/startup.sh /usr/bin/
RUN chmod +x /usr/bin/startup.sh

COPY /docker/prepare-db.sh /usr/bin/
RUN chmod +x /usr/bin/prepare-db.sh
    
ENTRYPOINT ["/usr/bin/startup.sh"]
EXPOSE 3000

CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]
