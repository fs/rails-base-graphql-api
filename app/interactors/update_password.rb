class UpdatePassword
  include Interactor::Organizer

  organize FindUserByToken,
           UpdateUserPassword
end
