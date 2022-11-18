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

def s3_options
  {
    access_key_id: ENV.fetch("S3_ACCESS_KEY_ID", nil),
    secret_access_key: ENV.fetch("S3_SECRET_ACCESS_KEY", nil),
    region: ENV.fetch("S3_BUCKET_REGION", nil),
    bucket: ENV.fetch("S3_BUCKET_NAME", nil)
  }
end

def amazon_s3_storages
  {
    cache: Shrine::Storage::S3.new(prefix: "cache", **s3_options),
    store: Shrine::Storage::S3.new(prefix: "store", upload_options: { acl: "public-read" }, **s3_options)
  }
end

def memory_storages
  {
    cache: Shrine::Storage::Memory.new,
    store: Shrine::Storage::Memory.new
  }
end

def filesystem_storages
  {
    cache: LocalStorage.new("public", prefix: "/uploads/cache"),
    store: LocalStorage.new("public", prefix: "/uploads")
  }
end

def local_storages
  Rails.env.test? ? memory_storages : filesystem_storages
end

if s3_options.values.all?(&:present?)
  Shrine.storages = amazon_s3_storages
else
  Shrine.plugin :upload_endpoint, upload_context: ->(request) { { key: request.params["key"] } }
  Shrine.storages = local_storages
end
