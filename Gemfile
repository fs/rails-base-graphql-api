source "https://rubygems.org"

ruby "2.6.6"

# the most important stuff
gem "pg"
gem "rails", "~> 6.0.3.4"

# all other gems
gem "aws-sdk-s3"
gem "bcrypt"
gem "bootsnap", require: false
gem "enumerize"
gem "graphql"
gem "graphql-batch"
gem "health_check"
gem "interactor"
gem "jwt"
gem "newrelic_rpm"
gem "puma"
gem "rack-cors"
gem "shrine"
gem "sidekiq"
gem "strong_migrations"

group :development do
  gem "letter_opener"
  gem "listen"
  gem "spring"
  gem "spring-watcher-listen"
end

group :development, :test do
  gem "brakeman"
  gem "bundler-audit"
  gem "byebug"
  gem "dotenv-rails"
  gem "factory_bot_rails"
  gem "ffaker"
  gem "rspec-rails"
  gem "rubocop", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rspec", require: false
end

group :test do
  gem "database_cleaner-active_record"
  gem "email_spec"
  gem "simplecov", require: false
end
