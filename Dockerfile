######################
# Stage: Builder
FROM ruby:2.7.5-alpine as Builder

ARG BUNDLER_VERSION

RUN apk add --update --no-cache \
    build-base \
    gcompat \
    postgresql-dev \
    git \
    imagemagick \
    tzdata

# Remove bundle config if exist
RUN rm -f .bundle/config

RUN gem install bundler:$BUNDLER_VERSION

WORKDIR /app

# Install gems
ARG BUNDLE_WITHOUT
ENV BUNDLE_WITHOUT ${BUNDLE_WITHOUT}

RUN bundle config set without ${BUNDLE_WITHOUT}

COPY . /app/
RUN bundle install -j4 --retry 3 \
 # Remove unneeded files (cached *.gem, *.o, *.c)
 && rm -rf /usr/local/bundle/cache/*.gem \
 && find /usr/local/bundle/gems/ -name "*.c" -delete \
 && find /usr/local/bundle/gems/ -name "*.o" -delete

# Remove folders not needed in resulting image
ARG FOLDERS_TO_REMOVE
RUN rm -rf $FOLDERS_TO_REMOVE

###############################
# Stage Final
FROM ruby:2.7.5-alpine as Final

# Add Alpine packages
RUN apk add --update --no-cache \
    build-base \
    gcompat \
    postgresql-client \
    imagemagick \
    tzdata \
    file \
    git

# Copy app with gems from former build stage
COPY --from=Builder /usr/local/bundle/ /usr/local/bundle/
COPY --from=Builder /app/ /app/

WORKDIR /app
