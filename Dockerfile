FROM ruby

CMD mkdir /lomax/
WORKDIR /lomax

ADD Gemfile .
RUN bundle install

CMD ruby archive_parser.rb
