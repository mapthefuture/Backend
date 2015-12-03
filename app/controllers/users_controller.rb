class UsersController < ApplicationController
  def site_ratings
    user = User.find(params[:id])
    @ratings = user.ratings.where(rateable_type: "Site")
    if @ratings && @ratings.first
      render "site_ratings.json.jbuilder", status: :ok
        # status: 200
    else
      render json: { error: "The user has no site ratings to display." },
        status: :not_found
          # status: 404
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
        status: :not_found
          # status: 404
    end
  end

  def tour_reviews
  end
end