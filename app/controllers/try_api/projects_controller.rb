module TryApi
  class ProjectsController < TryApi::ApplicationController

    def index
      @project = ConfigParser.read
      render json: {project: @project.to_json}
    end

  end
end