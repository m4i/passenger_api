# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

# Specify your gem's dependencies in passenger_api.gemspec
gemspec

if RUBY_VERSION > '2.0'
  gem 'rubocop', '0.49.1'
end

if RUBY_VERSION < '2.3'
  gem 'rack', '< 2'
end

if RUBY_VERSION < '1.9'
  gem 'json'
  gem 'rack-test', '< 0.7'
end
