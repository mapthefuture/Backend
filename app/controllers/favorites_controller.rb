class FavoritesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @tour = Tour.find(params[:tour_id])
    @favorite = @tour.favorites.new(user_id: current_user.id)
      if @favorite.save
        render "create.json.jbuilder", status: :created
          # status: 201
      else
        render json: { error: "You must be authenticated to favorite a tour." },
          status: :unauthorized
            # status: 401
      end
  end
  
  def destroy
    favorite = Favorite.where(id: params[:id], user_id: current_user.id).take
    if favorite 
      favorite.destroy
      render plain: "The favorite was deleted successfully.", status: :accepted
        # status: 202
    else 
      render json: { error: "Either the favorite does not exist, or you are not authorized to delete this favorite." },
        status: :unauthorized
          # status: 401
    end
  end
end
