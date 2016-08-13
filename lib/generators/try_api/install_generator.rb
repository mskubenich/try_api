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
      template 'config/try_api.yml', 'config/try_api.yml'

      Bundler.with_clean_env do
        run "mkdir vendor/assets/try_api"
        run "cd vendor/assets/try_api && bower install jquery"
        run "cd vendor/assets/try_api && bower install bootstrap"
        run "cd vendor/assets/try_api && bower install slimScroll"
        run "cd vendor/assets/try_api && bower install highlightjs"
      end

    end
  end
end