$:.unshift File.join(File.dirname(__FILE__), 'lib')
require 'rosette/extractors/json-extractor/version'

Gem::Specification.new do |s|
  s.name     = 'rosette-extractor-json'
  s.version  = ::Rosette::Extractors::JSON_EXTRACTOR_VERSION
  s.authors  = ['Cameron Dutro', 'Matt Low']
  s.email    = ['camertron@gmail.com', '11mdlow@gmail.com']
  s.homepage = "http://github.com/rosette-proj"

  s.description = s.summary = 'Extracts translatable strings from JSON files for the Rosette internationalization platform.'

  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true

  s.require_path = 'lib'
  s.files = Dir["{lib,spec}/**/*", 'Gemfile', 'History.txt', 'README.md', 'Rakefile', 'rosette-extractor-json.gemspec']

  s.add_dependency 'json-stream', '~> 0.2'
end
