class LocalStorage < Shrine::Storage::FileSystem
  include Rails.application.routes.url_helpers

  def presign(id, **options)
    {
      method: :post,
      url: images_upload_url,
      fields: { key: id }.merge(options)
    }
  end

  private

  def default_url_options
    Rails.application.config.action_controller.default_url_options
  end
end
