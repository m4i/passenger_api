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

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.2.2'

  spec.add_dependency 'passenger', '>= 5.0.22'
  spec.add_dependency 'rack'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'appraisal'
  spec.add_development_dependency 'rack-test'
  spec.add_development_dependency 'simplecov'
end
