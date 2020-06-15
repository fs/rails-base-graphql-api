require "shrine"
require "shrine/storage/file_system"
require "shrine/storage/s3"
require "shrine/storage/memory"

Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data
Shrine.plugin :determine_mime_type
Shrine.plugin :remove_attachment
Shrine.plugin :restore_cached_data
Shrine.plugin :validation
Shrine.plugin :validation_helpers
Shrine.plugin :presign_endpoint, presign_options: -> (request) {
  # Uppy will send the "filename" and "type" query parameters
  filename = request.params["filename"]
  type     = request.params["type"]

  {
    content_disposition:    ContentDisposition.inline(filename), # set download filename
    content_type:           type,                                # set content type (defaults to "application/octet-stream")
    content_length_range:   0..(10*1024*1024),                   # limit upload size to 10 MB
  }
}

def s3_options
  {
    access_key_id:     ENV["S3_ACCESS_KEY_ID"],
    secret_access_key: ENV["S3_SECRET_ACCESS_KEY"],
    region:            ENV["S3_BUCKET_REGION"],
    bucket:            ENV["S3_BUCKET_NAME"]
  }
end

def amazon_s3_storages
  {
    cache: Shrine::Storage::S3.new(prefix: "cache", **s3_options),
    store: Shrine::Storage::S3.new(prefix: "store", upload_options: { acl: "public-read" }, **s3_options)
  }
end

def local_storages
  if Rails.env.test?
    {
      cache: Shrine::Storage::Memory.new,
      store: Shrine::Storage::Memory.new
    }
  else
    {
      cache: Shrine::Storage::FileSystem.new("public", prefix: "/uploads/cache"),
      store: Shrine::Storage::FileSystem.new("public", prefix: "/uploads")
    }
  end
end

Shrine.storages = s3_options.values.all? ? amazon_s3_storages : local_storages
