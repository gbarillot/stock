class LocationsController < ApplicationController

  layout false

  def show
    @positions = Position.where("name LIKE (?)", "#{params[:slug].gsub('-', ' ')}%")
    @items = @positions
    @count = @positions.sum('quantity')
  end

end
