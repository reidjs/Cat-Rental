class CatsController < ApplicationController
  def new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    if @cat.save
      # render plain: "You made a cat!"
      redirect_to cat_url(@cat)
    else
      render json: @cat.errors.full_messages
    end
  end

  def index
    @cats = Cat.all
    if @cats
      render :index
    else
      render json: @cats.errors.full_messages
    end
  end

  def show
    @cat = Cat.find_by(id: params[:id])
    if @cat
      render :show
    else
      render json: @cat.errors.full_messages
    end
  end

  private
  def cat_params
    params.require(:cat).permit(:name, :birth_date, :sex, :color, :description)
  end
end
