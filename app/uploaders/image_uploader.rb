class ImageUploader < Shrine
  def generate_location(io, record: nil, name: nil, derivative: nil, metadata: {}, **options)
    options[:key] || super
  end
end
