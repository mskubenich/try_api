$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "try_api/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "try_api"
  s.version     = TryApi::VERSION
  s.authors     = ["Mykhaylo Skubenych"]
  s.email       = ["mykhaylo.skubenych@gmail.com"]
  s.homepage    = "https://github.com/mskubenich/try_api"
  s.summary     = %q{Generates API UI from simple .yml manifest.}
  s.description = %q{Generates UI for rails apps with APIs. You can easily test, share and play with you'r APIs. Enjoy ) }
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails"

  s.add_development_dependency "rspec"
  s.add_dependency "slim-rails"
  s.add_dependency "sass-rails"
  s.add_development_dependency "sqlite3"
end
