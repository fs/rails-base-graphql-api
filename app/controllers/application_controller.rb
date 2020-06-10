class ApplicationController < ActionController::API
  include AuthenticableUser
  include ExecutionErrorResponder
end
