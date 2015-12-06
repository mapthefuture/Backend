class RegistrationsController < ApplicationController
  before_action :authenticate_user!, except: [:create, :show]

  def create
    @user = User.new(user_params)
    if @user.save
      # WelcomeMailer.welcome(@user).deliver_now

      render "create.json.jbuilder", status: :created 
        # status: 201
    else
      render json: { errors: @user.errors.full_messages },
        status: :unprocessable_entity
          # status: 422
    end
  end

  def show
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      render "show.json.jbuilder", status: :accepted 
        # status 202
    else
      render json: { error: "Invalid email or password." },
        status: :unauthorized
          # status 401
    end
  end

  def update
    @user = User.find(params[:id])
    if current_user && @user.id == current_user.id
      @user.update(first_name: params[:first_name],
                   last_name: params[:last_name],
                   email: params[:email],
                   password: params[:password],
                   avatar: StringIO.new(Base64.decode64(params[:image])))
      # if @user.avatar == old_avatar
      #   render json: { error: "Warning -- avatar was not updated properly." },
      #     status: :not_modified
      #       # status: 304
      render "update.json.jbuilder", status: :accepted
          # status 202
    else 
      render json: { error: "You are not authorized to update this user." },
        status: :unauthorized
          # status 401
    end
  end

  def destroy
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      @user.destroy
      render plain: "The user has been deleted successfully.", status: :accepted # status 202
    else
      render json: { error: "Invalid email or password." },
        status: :unauthorized
        # status 401
    end
  end

  private

  def user_params
    params.permit(:first_name, :last_name, :email, :password, :avatar)
  end
end
