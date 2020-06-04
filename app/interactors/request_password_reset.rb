class RequestPasswordReset
  include Interactor::Organizer

  organize GenerateResetToken,
           SendRecoveryInstructions
end
