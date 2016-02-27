# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ngx/config/version'

Gem::Specification.new do |spec|
  spec.name          = "ngx-config"
  spec.version       = Ngx::Config::VERSION
  spec.authors       = ["Kiki"]
  spec.email         = ["kiki.hakiem@gmail.com"]

  spec.summary       = "ngx-config is the Ruby porting of the nginx-conf Node module. It is a gem for making changes to an nginx configuration file programmatically."
  spec.homepage      = "https://github.com/kikihakiem/ngx-config"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "shoulda-context", "~> 1.2"
end
