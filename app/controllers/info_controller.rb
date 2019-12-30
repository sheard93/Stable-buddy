class InfoController < ApplicationController
  def index
  end

  def list
    @items = current_user.items
  end
end
