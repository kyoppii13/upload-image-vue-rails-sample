module Api
  module V1
    class ItemsController < ApplicationController
      before_action :set_item, only: [:show, :destroy, :update]

      def index
        @items = Item.all
        render json: @items
      end

      def show
        render json: @item
      end

      def create
        item = Item.new(item_params)
        if item.save
          render json: item
        else
          render json: item.errors
        end
      end

      def destroy
        if @item.destroy
          render json: @item
        else
          render json: @item.errors
        end
      end

      def update
        if @item.update(item_params)
          render json: @item
        else
          render json: @item.errors
        end
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
