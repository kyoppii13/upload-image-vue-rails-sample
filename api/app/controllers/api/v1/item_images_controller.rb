module Api
  module V1
    class ItemImagesController < ApplicationController
      def index
        images = ItemImage.fetch_images
        render json: images, status: :ok
      end

      def upload
        params[:item_images].each do |image|
          @item_image = ItemImage.new(filename: image.original_filename,
                                      image: image.tempfile)

          @item_image.upload
        end
        head :ok
      end
    end
  end
end
