require 'bundler'

Gem::Specification.new do |s|
  s.name         = "riddler"
  s.version      = "0.1.0"
  s.author       = "Kyle Slattery"
  s.summary      = "Ruby wrapper for the Viddler API"
  s.email        = "kyle@viddler.com"
  s.homepage     = "http://github.com/viddler/riddler"
  s.platform     = Gem::Platform::RUBY
  s.files        = %w(README.md)
  s.files       += Dir.glob("lib/**/*")
  s.files       += Dir.glob("spec/**/*")
  s.add_bundler_dependencies
end
