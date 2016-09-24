class TryApi::ApplicationController < ActionController::Base


  rescue_from Exception do |exception|
    @message = exception.message
    begin
      render template: 'try_api/pages/config_file_not_found'
    rescue Exception => e
      render json: {error: exception.message}, status: 422
    end
  end

end