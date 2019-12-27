class ItemsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create]

  def index
    @items = current_user.items
  end

end
