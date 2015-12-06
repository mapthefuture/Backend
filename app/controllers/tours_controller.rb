class ToursController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def index
    @tours = Tour.includes(:ratings).all
    if @tours.first
      render "index.json.jbuilder", status: :ok 
        # status 200
    else
      render json: { error: "There are no tours to display." },
        status: :not_found
          # status 404
    end
  end

  def create
    @tour = current_user.tours.new(tour_params)
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
      render "show.json.jbuilder", status: :ok 
        # status 200
    end
  end

  def update
    @tour = Tour.find(params[:id])
    if @tour && @tour.user_id == current_user.id
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

  def favorited_by
    tour = Tour.find(params[:id])
    if tour && tour.favorites.first
      favorites = Favorite.where(favoritable_id: tour.id, favoritable_type: "Tour")
      @users = []
      favorites.each do |favorite|
        @users.push(User.find(favorite.user_id))
      end
      render "favorited_by.json.jbuilder", status: :ok
        # status: 200
    else
      render json: { error: "This tour hasn't been favorited by anyone yet." },
        status: :no_content
          # status 204
    end
  end

  private

  def tour_params
    params.permit(:title, :distance, :duration, :start_lat, :start_lon, 
                  :category, :description)
  end
end
