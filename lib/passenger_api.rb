# frozen_string_literal: true

require 'passenger_api/request'
require 'passenger_api/version'

class PassengerAPI
  def initialize
    require 'passenger_api/ext'
  end

  def call(env)
    to_rack_response(call_api(build_argv(Request.new(env))))
  end

  private

  def build_argv(req)
    argv = [req.method, req.path]
    argv << '--data' << req.body unless req.body.empty?
    argv
  end

  def call_api(argv)
    argv += ['--show-headers']
    catch :response do
      PhusionPassenger::Config::ApiCallCommand.new(argv).run
    end
  end

  def to_rack_response(res)
    # for Ruby 1.8.7
    # headers = res.each_capitalized.to_h
    headers = {}
    res.each_capitalized { |n, v| headers[n] = v }

    [res.code, headers, [res.body]]
  end
end
