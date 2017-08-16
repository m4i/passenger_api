# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'passenger_api/version'

Gem::Specification.new do |spec|
  spec.name          = 'passenger_api'
  spec.version       = PassengerAPI::VERSION
  spec.authors       = ['Masaki Takeuchi']
  spec.email         = ['m.ishihara@gmail.com']

  spec.summary       = 'A Rack application to access Passenger internal APIs'
  spec.description   = 'PassengerAPI is a Rack application to access Passenger internal APIs.'
  spec.homepage      = 'https://github.com/m4i/passenger_api'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 1.8.7'

  spec.add_dependency 'passenger', '>= 5.0.10'

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'appraisal'
  spec.add_development_dependency 'rack-test'
  spec.add_development_dependency 'simplecov'
end
