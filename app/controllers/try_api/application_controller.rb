class TryApi::ApplicationController < ActionController::Base


  rescue_from Exception do |exception|
    @message = exception.message
    render template: 'try_api/pages/config_file_not_found'
  end

end