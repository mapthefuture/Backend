class ToursController < ApplicationController
  # before_action :authenticate_user!, except: [:index, :show]

  def index
    @tours = Tour.all
    if @tours.first
      render "index.json.jbuilder", status: :ok 
        # status 200
    else
      render json: { error: "There are no tours to display."},
        status: :unprocessable_entity
          # status 422
    end
  end

  def create
    @tour = Tour.new(tour_params)
    if @tour.save
      render "create.json.jbuilder", status: :created 
        # status 201
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

  def update
    @tour = Tour.find(params[:id])
    if @tour # && tour.user_id == current_user.id
      @tour.update(tour_params)
      render "update.json.jbuilder", status: :accepted
        # status 202
    end
  end

  def destroy
    tour = Tour.find(params[:id])
    if tour # && tour.user_id == current_user.id
      tour.destroy
      render plain: "The tour has been deleted successfully."
    end
  end

  private

  def tour_params
    params.permit(:title, :distance, :duration, :start_lat, :start_lon, :category, :description, :user_id) # user_id needs to be removed when authentication has been implemented
  end
end