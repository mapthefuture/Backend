class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_action :json_defaults

  rescue_from ActiveRecord::RecordNotFound do |error|
    render json: { error: "Could not find object: #{error.message}" },
      status: :not_found
  end

  def json_defaults
    request.format = :json unless params[:format]
  end
end
