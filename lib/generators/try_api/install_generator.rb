require 'rails/generators'

module TryApi
  class InstallGenerator < ::Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)
    desc "This generator generates config file for API interface."

    def init_environment
      app = ::Rails.application
      @app_name = app.class.to_s.split("::").first
    end

    def create_config_file
      directory 'try_api', 'config/try_api'
    end
  end
end