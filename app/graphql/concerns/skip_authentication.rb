module SkipAuthentication
  extend ActiveSupport::Concern

  def authenticate(*)
    true
  end
end
