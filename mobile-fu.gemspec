# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "mobile-fu/version"

Gem::Specification.new do |s|
  s.name        = "mobile-fu"
  s.version     = MobileFu::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Brendan Lim", "Ben Langfeld"]
  s.email       = ["brendangl@gmail.com, ben@langfeld.me"]
  s.homepage    = "https://github.com/benlangfeld/mobile-fu"
  s.summary     = %q{Automatically detect mobile requests from mobile devices in your Rails application.}
  s.description = %q{Want to automatically detect mobile devices that access your Rails application? Mobile Fu allows you to do just that. People can access your site from a Palm, Blackberry, iPhone, iPad, Nokia, etc. and it will automatically adjust the format of the request from :html to :mobile.}

  s.rubyforge_project = "mobile-fu"

  s.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  s.executables   = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths  = ['lib']

  s.add_dependency 'rails'
  s.add_dependency 'rack-mobile-detect'
  s.add_development_dependency 'mocha'
  s.add_development_dependency 'rdoc'
  s.add_development_dependency 'httparty'
end
