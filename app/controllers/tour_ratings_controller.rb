class TourRatingsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    tour = Tour.find(params[:id])
    if tour && tour.ratings.first
      @ratings = tour.ratings
      render "index.json.jbuilder", status: :ok
        # status: 200
    else 
      render json: { error: "The requested tour has no ratings to display." },
        status: :not_found
          # status: 404
    end
  end

  def create
    tour = Tour.find(params[:id])
    @rating = tour.ratings.new(rating_params)
      if @rating.score.between?(1,5)
        @rating.save
        render "create.json.jbuilder", status: :created 
          # status: 201
      else 
        render json: { error: "You must enter a valid rating (1 - 5)" },
          status: :bad_request
            # status: 400
      end
  end

  def show
    @rating = Rating.find(params[:id])
    if @rating
      render "show.json.jbuilder", status: :ok
        # status: 200
    end
  end

  def update 
    self.find_tour
    if @tour && @rating.rateable_type == "Tour"
      old_score = @rating.score
      @rating.update(rating_params)
      if @rating.score.between?(1,5)
        render "update.json.jbuilder", status: :accepted # status 202
      else
        @rating.update(score: old_score)
        render json: { error: "You must enter a valid rating (1 - 5)" },
          status: :unprocessable_entity
            # status: 422
      end
    else
      render json: { error: "You are not authorized to update the requested rating." },
        status: :unauthorized
          # status: 401
    end
  end

  def destroy
    self.find_tour
    if @tour && @rating.rateable_type == "Tour"
      @rating.destroy
      render plain: "The rating has been deleted successfully.",
        status: :accepted
    else
      render json: { error: "Either the rating does not exist, or you are not authorized to delete it." },
        status: :unauthorized
          # status 401
    end
  end

  def find_tour
    @rating = Rating.find(params[:id])
    @tour = current_user.tours.find_by(id: @rating.rateable_id)
  end

  private

  def rating_params
    params.permit(:score)
  end
end
