class ToursController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]

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

  def nearby
    @tours = Tour.includes(:ratings).near([params[:latitude].to_f, params[:longitude].to_f], params[:radius].to_f) # radius in kms
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
    render "show.json.jbuilder", status: :ok 
        # status 200
  end

  def update
    @tour = Tour.find(params[:id])
    if @tour.user_id == current_user.id
      @tour.update(tour_params)
      render "update.json.jbuilder", status: :accepted
        # status 202
    else 
      render json: { error: "You are not authorized to update this tour." },
        status: :unauthorized
          # status 401
    end
  end

  def destroy
    tour = Tour.find(params[:id])
    if tour.user_id == current_user.id
      tour.destroy
      render plain: "The tour has been deleted successfully."
    end
  end

  def favorited_by
    tour = Tour.find(params[:id])
    if tour.favorites.first
      favorites = Favorite.where(favoritable_id: tour.id, favoritable_type: "Tour")
      @users = []
      favorites.each do |favorite|
        @users.push(User.find(favorite.user_id))
      end
      render "favorited_by.json.jbuilder", status: :ok
        # status: 200
    else
      render plain: "This tour hasn't been favorited by anyone yet."
    end
  end

  private

  def tour_params
    params.permit(:title, :length, :duration, :start_lat, :start_lon, 
                  :category, :description, :street, :city, :state, :zip, :country)
  end
end
