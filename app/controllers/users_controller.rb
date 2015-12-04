class UsersController < ApplicationController
  def site_ratings
    user = User.find(params[:id])
    @ratings = user.ratings.where(rateable_type: "Site")
    if @ratings && @ratings.first
      render "site_ratings.json.jbuilder", status: :ok
        # status: 200
    else
      render json: { error: "The user has no site ratings to display." },
        status: :no_content
          # status: 204
    end
  end

  def tour_ratings
    user = User.find(params[:id])
    @ratings = user.ratings.where(rateable_type: "Tour")
    if @ratings && @ratings.first
      render "tour_ratings.json.jbuilder", status: :ok
        # status: 200
    else
      render json: { error: "The user has no tour ratings to display." },
        status: :no_content
          # status: 204
    end
  end

  def tour_reviews
    user = User.find(params[:id])
    @reviews = user.reviews
    if @ratings && @ratings.first
      render "tour_reviews.json.jbuilder", status: :ok
        # status: 200
    else
      render json: { error: "The user has no tour reviews to display." },
        status: :no_content
          # status: 204
    end
  end

  def favorites
    user = User.find(params[:id])
    tours = user.tours
    @favorites = user.favorite_tours
    if @favorites.first
      render "favorites.json.jbuilder", status: :ok
        # status 200
    else
      render json: { error: "This user has no favorites to display." },
        status: :no_content
          # status 204
    end
  end
end
