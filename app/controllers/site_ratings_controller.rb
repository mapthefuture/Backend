class SiteRatingsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    site = Site.find(params[:id])
    if site && site.ratings.first
      @ratings = site.ratings
      render "index.json.jbuilder", status: :ok
        # status: 200
    else 
      render json: { error: "The requested site has no ratings to display." },
        status: :not_found
          # status: 404
    end
  end

  def create
    site = Site.find(params[:id])
    if current_user.ratings.exists?(rateable_id: site.id, rateable_type: "Site")
      render json: { error: "User cannot rate a site more than once." },
        status: :forbidden
          # status: 403
    else 
      @rating = site.ratings.new(score: params[:score], user_id: current_user.id)
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
  end

  def show
    @rating = Rating.find(params[:id])
    if @rating
      render "show.json.jbuilder", status: :ok
        # status: 200
    end
  end

  def update 
   @rating = Rating.find(params[:id])
    if self.validate_rating_ownership
      old_score = @rating.score
      @rating.update(score: params[:score])
      if @rating.score.between?(1,5)
        render "update.json.jbuilder", status: :accepted 
          # status 202
      else
        @rating.update(score: old_score)
        render json: { error: "You must enter a valid rating (1 - 5)" },
          status: :bad_request
            # status: 400
      end
    else
      render json: { error: "You are not authorized to update the requested rating." },
        status: :unauthorized
          # status: 401
    end
  end

  def destroy
    @rating = Rating.find(params[:id])
    if self.validate_rating_ownership
      @rating.destroy
      render plain: "The rating has been deleted successfully.",
        status: :accepted
    else
      render json: { error: "Either the rating does not exist, or you are not authorized to delete it." },
        status: :unauthorized
          # status 401
    end
  end

  def validate_rating_ownership
    current_user.id == @rating.user_id
  end
end
