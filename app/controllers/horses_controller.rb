class HorsesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def destroy
    @horse = Horse.find_by_id(params[:id])
    return render_not_found if @horse.blank?
    return render_not_found(:forbidden) if @horse.user != current_user
    @horse.destroy
    redirect_to root_path
  end

  def update
    @horse = Horse.find_by_id(params[:id])
    return render_not_found if @horse.blank?
    return render_not_found(:forbidden) if @horse.user != current_user
    @horse.update_attributes(horse_params)
    if @horse.valid?
      redirect_to root_path
    else
      return render :edit, status: :unprocessable_entity
    end
  end

  def index

  end

  def new
    @horse = Horse.new
  end

  def show
    @horse = Horse.find_by_id(params[:id])
    return render_not_found if @horse.blank?
  end

  def edit
    @horse = Horse.find_by_id(params[:id])
    return render_not_found if @horse.blank?
    return render_not_found(:forbidden) if @horse.user != current_user
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

  def render_not_found(status=:not_found)
    render plain: "#{status.to_s.titleize}", status: status
  end
end
