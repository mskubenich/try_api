class TryApi::ApplicationController < ActionController::Base


  rescue_from Exception do |exception|
    @message = exception.message
    render json: {error: exception.message}, status: 422
  end

end