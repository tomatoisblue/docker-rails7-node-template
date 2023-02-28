FROM ruby:3.1

# Update package list
RUN apt update -qq &&\
    apt install -qq -y curl gnupg2 vim&&\
    curl -sL https://deb.nodesource.com/setup_16.x | bash - &&\
    apt install -qq -y nodejs &&\
    npm install -g yarn 

# Create a working directory
RUN mkdir /src
# Set a working directory
WORKDIR /src
# Copy Gemfile and Gemfile.lock
COPY Gemfile ./Gemfile
COPY Gemfile.lock ./Gemfile.lock
# Run bundle install
RUN bundle install

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# EXPOSE port 3000 for puma server
EXPOSE 3000

CMD ["rails", "s", "-b", "0.0.0.0"]
