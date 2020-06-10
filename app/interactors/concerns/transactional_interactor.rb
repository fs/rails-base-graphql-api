module TransactionalInteractor
  extend ActiveSupport::Concern

  included do
    around do |interactor|
      ActiveRecord::Base.transaction do
        interactor.call(context)
      end
    end
  end
end
