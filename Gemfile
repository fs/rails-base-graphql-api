source "https://rubygems.org"

ruby "2.6.5"

# the most important stuff
gem "pg"
gem "rails", "6.0.2.1"

# all other gems
gem "bcrypt"
gem "bootsnap", require: false
gem "decent_exposure"
gem "graphql"
gem "health_check"
gem "interactor"
gem "jwt"
gem "puma"

group :development do
  gem "listen"
  gem "spring"
  gem "spring-watcher-listen"
end

group :development, :test do
  gem "factory_bot_rails"
  gem "ffaker"
  gem "byebug"
  gem "rspec-rails"
end

group :test do
  gem "database_cleaner-active_record"
  gem "simplecov", require: false
end

