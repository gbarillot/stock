class LocationsController < ApplicationController

  layout false

  def show
    if params[:slug] == '*'
      @level = 0
      @locations = Position.where("level = 0").order('name ASC')
    else
      @level = params[:slug].split('-').length
      @locations = Position.where(["name ILIKE (?) AND level = ?", "#{params[:slug].gsub('-', ' ')}%", @level])
    end
  end

  def create
    params[:kind] == 'position' ? product_id = 0 : product_id = nil
    if params[:slug] == '*'
      new_name = "#{params[:location][:name]}".downcase
      level = 0
    else
      if params[:location]
        new_name = "#{params[:slug].gsub('-', ' ')} #{params[:location][:name]}".downcase
        level = params[:slug].split('-').length
      else
        new_name = ''
      end
    end
    volume = params[:location][:width].to_i * params[:location][:height].to_i * params[:location][:depth].to_i

    position = Position.new(
      name: new_name.upcase,
      level: level,
      product_id: product_id,
      width: params[:location][:width],
      height: params[:location][:height],
      depth: params[:location][:depth],
      free: volume,
      volume: volume
    )

    if position.save
      if params[:slug] == '*'
        @level = 0
        @locations = Position.where("level = 0").order('name ASC')
      else
        @level = params[:slug].split('-').length
        @locations = Position.where(["name ILIKE (?) AND level = ?", "#{params[:slug].gsub('-', ' ')}%", @level])
      end

      render template: '/locations/show'
    else
      render json: {errors: position.errors}.to_json, status: 422
    end
  end

end
