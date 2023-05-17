module Mutations
  class PresignData < BaseMutation
    description "Presign file data mutation"

    argument :input, Types::PresignDataInput, "Data Input", required: true

    type Types::Payloads::PresignDataPayload

    def resolve(input:)
      presign_image = PreparePresignImage.call(input.to_h)

      presign_image.success? ? presign_image : execution_error(error_data: presign_image.error_data)
    end
  end
end
