module TryApi
  class PagesController < TryApi::ApplicationController
    layout 'try_api/application'

    def index
      @project = ConfigParser.read
    end

  end
end