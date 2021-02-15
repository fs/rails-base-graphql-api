module Mutations
  class PresignData < BaseMutation
    argument :input, Types::PresignDataInput, required: true

    type Types::PresignType

    def resolve(input:)
      presign_image = PreparePresignImage.call(input.to_hash)

      if presign_image.success?
        presign_image.presign_data
      else
        execution_error(error_data: presign_image.error_data)
      end
    end
  end
end
