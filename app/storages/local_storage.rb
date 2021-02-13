class LocalStorage < Shrine::Storage::FileSystem
  delegate :images_upload_url, to: :url_helpers

  def presign(id, **options)
    {
      method: :post,
      url: images_upload_url(default_url_options),
      fields: { key: id }.merge(options)
    }
  end

  private

  def url_helpers
    Rails.application.routes.url_helpers
  end

  def default_url_options
    Rails.application.config.action_controller.default_url_options
  end
end
