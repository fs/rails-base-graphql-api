######################
# Stage: Builder
FROM ruby:2.6.5-alpine as Builder

ARG BUNDLER_VERSION

RUN apk add --update --no-cache \
    build-base \
    postgresql-dev \
    git \
    imagemagick \
    tzdata
RUN gem install bundler:$BUNDLER_VERSION

WORKDIR /app

# Install gems
ARG BUNDLE_WITHOUT
ENV BUNDLE_WITHOUT ${BUNDLE_WITHOUT}

RUN bundle config set without ${BUNDLE_WITHOUT}

COPY Gemfile* /app/
RUN bundle install -j4 --retry 3 \
 # Remove unneeded files (cached *.gem, *.o, *.c)
 && rm -rf /usr/local/bundle/cache/*.gem \
 && find /usr/local/bundle/gems/ -name "*.c" -delete \
 && find /usr/local/bundle/gems/ -name "*.o" -delete

# Add the Rails app
COPY . /app/

# Remove folders not needed in resulting image
ARG FOLDERS_TO_REMOVE
RUN rm -rf $FOLDERS_TO_REMOVE

###############################
# Stage Final
FROM ruby:2.6.5-alpine

# Add Alpine packages
ARG ADDITIONAL_PACKAGES
RUN apk add --update --no-cache \
    postgresql-client \
    imagemagick \
    tzdata \
    file \
    $ADDITIONAL_PACKAGES

# Copy app with gems from former build stage
COPY --from=Builder /usr/local/bundle/ /usr/local/bundle/
COPY --from=Builder /app/ /app/

WORKDIR /app

CMD ["bin/docker-entrypoint"]

# Expose Server port
EXPOSE 3000

# Set Rails env
ENV RAILS_LOG_TO_STDOUT true