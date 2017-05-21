class PositionsController < ApplicationController

  def index
    @positions = Positions.all
  end

  def show
  end

  def create
    @products = Position.search(params[:id])
  end

end
