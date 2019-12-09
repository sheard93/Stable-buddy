class HorsesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index

  end

  def new
    @horse = Horse.new
  end

  def create
    @horse = current_user.horses.create(horse_params)
    if @horse.valid?
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def horse_params
    params.require(:horse).permit(:name, :owner, :age, :breed)
  end
end
