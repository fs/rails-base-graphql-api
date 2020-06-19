module Mutations
  class PresignData < BaseMutation
    argument :filename, String, required: true
    argument :type, String, required: true

    type Types::PresignType

    def resolve(filename:, type:)
      presign_upload = PreparePresignImage.call(filename: filename, type: type)

      if presign_upload.success?
        sanitized_data(presign_upload.presign_data)
      else
        execution_error(error_data: presign_upload.error_data)
      end
    end

    private

    def sanitized_data(data)
      {
        url: data.dig(:url),
        headers: data.dig(:headers).to_json,
        fields: data.dig(:fields).to_json
      }
    end
  end
end
