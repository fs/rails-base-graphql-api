class PreparePresignImage
  include Interactor

  ALLOWED_TYPES = %w[image/jpeg image/png image/webp].freeze
  UPLOAD_SIZE_LIMIT = 10.megabyte

  PRESIGN_DATA = Struct.new(:url, :fields)
  PRESIGN_FIELD = Struct.new(:key, :value)

  delegate :filename, :type, to: :context

  def call
    context.fail!(error_data: error_data) unless ALLOWED_TYPES.include?(type)
    context.presign_data = presign_data
  end

  private

  def presign_data
    PRESIGN_DATA.new(upload_params.dig(:url), presign_fields)
  end

  def presign_fields
    upload_params.dig(:fields).map do |key, value|
      PRESIGN_FIELD.new(key, value)
    end
  end

  def upload_params
    @upload_params ||= storage.presign(location, **options).slice(:url, :fields)
  end

  def location
    SecureRandom.hex + File.extname(filename)
  end

  def options
    {
      content_disposition: ContentDisposition.inline(filename),
      content_type: type,
      content_length_range: 0..UPLOAD_SIZE_LIMIT
    }
  end

  def storage
    Shrine.find_storage(:cache)
  end

  def error_data
    { message: "Wrong file type", status: 415, code: :unsupported_media_type }
  end
end
