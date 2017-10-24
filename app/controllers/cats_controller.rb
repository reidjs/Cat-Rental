class CatsController < ApplicationController
  def new
    @cat = Cat.new
    render :new
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
end
