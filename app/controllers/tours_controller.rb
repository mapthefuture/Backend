class ToursController < ApplicationController

  def index
    @tours = Tour.all
    if @tours
      render "index.json.jbuilder", status: :ok # status 200
    end
  end

  def create
    @tour = Tour.new(tour_params)
    if @tour.save
      render "create.json.jbuilder", status: :created # status 201
    else
      render json: { error: "The tour could not be created."},
        status: :unprocessable_entity
        # status 422
    end
  end

  def show
    @tour = Tour.find(params[:id])
    if @tour
      render "show.json.jbuilder", status: :ok # status 200
    end
  end

  private

  def tour_params
    params.permit(:title, :distance, :duration, :start_lat, :start_lon, :category, :description, :user_id) # user_id needs to be removed when authentication has been implemented
  end
end