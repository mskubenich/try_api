require 'rails/generators'

module TryApi
  class InstallGenerator < ::Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)
    desc "This generator generates all necessary files for API interface."

    def init_environment
      app = ::Rails.application
      @app_name = app.class.to_s.split("::").first
      ext = app.config.generators.options[:rails][:template_engine] || :erb
    end

    def install_js_dependencies
      Bundler.with_clean_env do
        run 'mkdir vendor/assets/try_api'
        run "cd vendor/assets/try_api && bower install angular"
        run "cd vendor/assets/try_api && bower install angular-bootstrap"
      end
    end
  end
end