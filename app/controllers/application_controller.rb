class ApplicationController < ActionController::API
  include AuthenticableUser
  include ValidatableToken
end
