# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mailbullet/version'

Gem::Specification.new do |spec|
  spec.name          = "mailbullet"
  spec.version       = Mailbullet::VERSION
  spec.authors       = ["TM Lee"]
  spec.email         = ["tm89lee@gmail.com"]
  spec.description   = "Ruby wrapper for Mailgun (www.mailgun.com) Web API"
  spec.summary       = "Ruby wrapper for Mailgun (www.mailgun.com) Web API"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency('faraday', '~> 0.8')
  spec.add_dependency('json', '~> 1.7.7')
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency('fakeweb', "~> 1.3.0")
end
