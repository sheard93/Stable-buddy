class ItemsController < ApplicationController


  def index
    @items = Item.all
    # @items = current_user.items
  end

end
