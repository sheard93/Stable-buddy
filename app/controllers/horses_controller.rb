class HorsesController < ApplicationController

  def index

  end

  def new
    @horse = Horse.new
  end

  def create
    @horse = Horse.create(horse_params)
    redirect_to root_path
  end

  private

  def horse_params
    params.require(:horse).permit(:name, :owner, :age, :breed)
  end
end
