class ItemsController < ApplicationController
  def index
    @items = Item.all
    return :items
  end
end
