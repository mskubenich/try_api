module TryApi
  class PagesController < TryApi::ApplicationController
    layout 'api_test/application'

    def index
      @project = ConfigParser.read
    end

  end
end