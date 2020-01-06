class ItemsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create]

  def index
    # @items = current_user.items
    render json: Item.order(:id)
  end

  def update
    item = Item.find(params[:id])
    item.update_attributes(item_params)
    
    render json: item
  end

  def create
    item = Item.create(item_params)
    render json: item
  end

  private

  def item_params
    params.require(:item).permit(:done, :title)
  end


end
