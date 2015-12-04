class ReviewsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    tour = Tour.find(params[:id])
    if tour && tour.reviews.first
      @reviews = tour.reviews
      render "index.json.jbuilder", status: :ok
        # status: 200
    else
      render json: { error: "The tour you've requested has no reviews to display." },
        status: :not_found
          # status: 404
    end    
  end

  def create
    tour = Tour.find(params[:id])
    @review = tour.reviews.new(tagline: params[:tagline],
                               body: params[:body],
                               user_id: current_user.id)
    if @review.save
      render "create.json.jbuilder", status: :created
        # status: 201
    else
      render json: { error: "You must be authenticated to create a review." },
        status: :unauthorized
          # status: 401
    end
  end

  def show
    @review = Review.find(params[:id])
    render "show.json.jbuilder", status: :ok
      # status: 200
  end

  def update
    @review = Review.find(params[:id])
    if @review.user_id == current_user.id
      @review.update(tagline: params[:tagline],
                     body: params[:body],
                     user_id: current_user.id)
      render "update.json.jbuilder", status: :accepted
        # status: 202
    else
      render json: { error: "You are not authorized to update this review." },
        status: :unauthorized
         # status: 401
    end
  end

  def destroy
    review = Review.find(params[:id])
    if review.user_id == current_user.id
      review.destroy
      render plain: "The requested review has been deleted."
    else
      render json: { error: "You are not authorized to delete this review." },
        status: :unauthorized
          # status 401
    end
  end
end
