class UploadsController < ApplicationController
  def image
    ImageUploader.upload_response(:cache, request.env)
  end
end
