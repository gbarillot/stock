class LocationsController < ApplicationController

  layout false

  def show
    @positions = Position.joins(:product).where("product_id IS NOT NULL AND products.reference != '0000' AND positions.name ILIKE (?)", "#{params[:slug].gsub('-', ' ')}%")
    @items = @positions
    @count = @positions.sum('quantity')
  end

end
