source "https://rubygems.org"

ruby "2.6.5"

# the most important stuff
gem "pg"
gem "rails", "6.0.3.1"

# all other gems
gem "bcrypt"
gem "bootsnap", require: false
gem "decent_exposure"
gem "graphql"
gem "health_check"
gem "interactor"
gem "jwt"
gem "puma"
gem "rack-cors"

group :development do
  gem "graphiql-rails"
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
  gem "simplecov", require: false
end
