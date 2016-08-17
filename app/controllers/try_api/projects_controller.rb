module TryApi
  class ProjectsController < TryApi::ApplicationController
    layout 'api_test/application'

    def index
      @project = ConfigParser.read
      render json: {project: @project.to_json}
    end

  end
end