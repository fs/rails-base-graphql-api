module SkipAuthentication
  extend ActiveSupport::Concern

  def ready?(*)
    true
  end
end
