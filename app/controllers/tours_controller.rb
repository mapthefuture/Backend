class ToursController < ApplicationController

  def index
    @tours = Tour.all
    if @tours
      render "index.json.jbuilder"
    end
  end

  def create
    @tour = Tour.new(tour_params)
    if @tour.save
      render "create.json.jbuilder"
    else
      render json: { error: "The tour could not be created."},
        status: :unprocessable_entity
        # status: 422
    end
  end

  private

  def tour_params
    params.permit(:title, :length, :user_id) # user_id needs to be removed when authentication has been implemented
  end
end