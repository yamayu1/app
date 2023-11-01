FROM ruby:3.1
ARG RUBYGEMS_VERSION=3.3.20
RUN mkdir /rails_practice
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && apt-get install -y nodejs
# RUN npm install --global yarn && npm install -g n && n 16.15.1
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update -qq \
    && apt-get install -y nodejs yarn \
    && mkdir /animal-system

WORKDIR /rails_practice
COPY Gemfile /rails_practice/Gemfile
COPY Gemfile.lock /rails_practice/Gemfile.lock
RUN gem install bundler:2.3.26
RUN bundle install
COPY . /rails_practice

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
