module Mutations
  class PresignData < BaseMutation
    argument :filename, String, required: true
    argument :type, String, required: true

    type Types::PresignType

    def resolve(filename:, type:)
      presign_image = PreparePresignImage.call(filename: filename, type: type)

      if presign_image.success?
        presign_image.presign_data
      else
        execution_error(error_data: presign_image.error_data)
      end
    end
  end
end
