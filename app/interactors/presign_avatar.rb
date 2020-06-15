class PresignAvatar
  include Interactor

  delegate :filename, :type, to: :context

  def call
    context.presign_data = presign_data
  end

  private

  def presign_data
    { fields: {}, headers: {} }.merge(storage.presign(location, **options).to_h)
  end

  def location
    uploader.send(:generate_uid, nil) + extension
  end

  def extension
    File.extname(filename)
  end

  def uploader
    Shrine.new(:cache)
  end

  def storage
    @storage ||= Shrine.find_storage(:cache)
  end

  def options
    {
      content_disposition:    ContentDisposition.inline(filename), # set download filename
      content_type:           type,                                # set content type (defaults to "application/octet-stream")
      content_length_range:   0..(10*1024*1024),                   # limit upload size to 10 MB
    }
  end
end
