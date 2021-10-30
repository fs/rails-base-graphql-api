module Mutations
  class PresignData < BaseMutation
    argument :input, Types::PresignDataInput, required: true

    type Types::Payloads::PresignDataPayload

    def resolve(input:)
      presign_image = PreparePresignImage.call(input.to_h)

      presign_image.success? ? presign_image : execution_error(error_data: presign_image.error_data)
    end
  end
end
