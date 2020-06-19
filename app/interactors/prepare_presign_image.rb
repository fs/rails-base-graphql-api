class PreparePresignImage
  include Interactor

  ALLOWED_TYPES = %w[image/jpeg image/png image/webp].freeze
  UPLOAD_SIZE_LIMIT = 10.megabyte

  delegate :filename, :type, to: :context

  def call
    context.fail!(error_data: error_data) unless ALLOWED_TYPES.include?(type)
    context.presign_data = presign_data
  end

  private

  def presign_data
    { fields: {}, headers: {} }.merge(upload_params)
  end

  def upload_params
    storage.presign(location, **options).to_h
  end

  def location
    uploader.send(:generate_uid, nil) + File.extname(filename)
  end

  def uploader
    Shrine.new(:cache)
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
