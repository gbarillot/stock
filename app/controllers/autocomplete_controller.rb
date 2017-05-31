class AutocompleteController < ApplicationController

  layout false

  def show
    send(params[:topic])

    if @template
      render template: "/autocomplete/#{@template}"
    else
      render template: "/autocomplete/#{params[:topic]}"
    end
  end

  def products
    @products = Product.autocomplete(params[:q])
  end

  def positions
    @positions = Position.autocomplete(params[:q])
    @items = @positions
    @count = @positions.sum('quantity')
  end

  def availabilities
    @positions = Position.availabilities(params[:q])
    @items = @positions
    @count = @positions.sum('quantity')

    @template = 'positions'
  end

end
