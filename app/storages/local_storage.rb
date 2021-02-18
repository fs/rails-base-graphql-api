class LocalStorage < Shrine::Storage::FileSystem
  delegate :images_upload_url, to: :url_helpers

  def presign(id, **options)
    {
      method: :post,
      url: images_upload_url(default_url_options),
      fields: { key: [storage_key, id].join("/") }.merge(options)
    }
  end

  def url(id, **_options)
    req = ActionDispatch::Request.new("HTTP_HOST" => ENV["HOST"])

    [req.url, prefix, id].join("/")
  end

  private

  def storage_key
    Shrine.storages.key(self)
  end

  def url_helpers
    Rails.application.routes.url_helpers
  end

  def default_url_options
    Rails.application.config.action_controller.default_url_options
  end
end
