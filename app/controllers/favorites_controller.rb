class FavoritesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @tour = Tour.find(params[:tour_id])
    if Favorite.find_by(user_id: current_user.id, 
                        favoritable_id: @tour.id, 
                        favoritable_type: "Tour")
    render json: { error: "You can't favorite a tour twice!" },
        status: :forbidden
          # status: 403
    else
      @favorite = @tour.favorites.create(user_id: current_user.id)
      render "create.json.jbuilder", status: :created
        # status: 201
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
