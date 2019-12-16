class ListsController < ApplicationController
  def index
    render json: Item.all
  end

  def new
    @item = Item.new
  end
end
