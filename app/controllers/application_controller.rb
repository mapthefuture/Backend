class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_action :json_defaults
  helper_method :current_user, :authenticate_user!

  rescue_from ActiveRecord::RecordNotFound do |error|
    render json: { error: "Could not find object: #{error.message}" },
      status: :not_found
  end

  def current_user
    token = request.headers['Access-Token']
    token && User.find_by(access_token: token)
  end

  def authenticate_user!
    unless current_user
      token = request.headers['Access-Token']
      render json: { error: "Could not authenticate with token:'#{token}'" },
        status: :unauthorized
    end
  end

  def json_defaults
    request.format = :json unless params[:format]
  end
end
