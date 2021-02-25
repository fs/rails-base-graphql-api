class ImageUploader < Shrine
  def generate_location(io, record: nil, derivative: nil, **options)
    options[:key]&.split("/")&.last || super
  end
end
