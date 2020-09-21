module Api
  module V1
    class ItemsController < ApplicationController
      before_action :set_item, only: [:show]

      def index
        @items = Item.all
        render json: @items
      end

      def show
        render json: @item
      end

      private

      def set_item
        @item = Item.find(params[:id])
      end

      def item_params
        params.require(:item).permit(:title, :image_url)
      end
    end
  end
end
