# frozen_string_literal: true

require 'passenger_api/version'

require 'json'
require 'net/http'

require 'rack/request'

unless defined?(PhusionPassenger)
  require 'phusion_passenger'
  PhusionPassenger.locate_directories
end
PhusionPassenger.require_passenger_lib('admin_tools/instance_registry')

class PassengerAPI
  def call(env)
    rack_request = Rack::Request.new(env)
    proxy_api(rack_request)
  end

  private

  def proxy_api(rack_request)
    dir = rack_request.get_header('HTTP_X_PASSENGER_INSTANCE_REGISTRY_DIR')
    instances = PhusionPassenger::AdminTools::InstanceRegistry.new(dir).list
    net_http_request = convert_rack_request_to_net_http_request(rack_request)

    responses = instances.map do |instance|
      build_response(instance, call_api(instance, net_http_request))
    end

    [200, { 'Content-Type' => 'application/json' }, [responses.to_json]]
  end

  def build_response(instance, net_http_response)
    {
      instance: instance.as_json.merge(state: instance.state),
      status:   net_http_response.code.to_i,
      header:   net_http_response.each_capitalized.to_h,
      body:     net_http_response.body,
    }
  end

  def call_api(instance, net_http_request)
    net_http_request.basic_auth('admin', instance.full_admin_password)
    instance.http_request('agents.s/core_api', net_http_request)
  end

  def convert_rack_request_to_net_http_request(rack_request)
    klass = Net::HTTP.const_get(rack_request.request_method.capitalize)
    header = {}
    if rack_request.content_type
      header['Content-Type'] = rack_request.content_type
    end
    net_http_request = klass.new(rack_request.fullpath, header)
    body = rack_request.body.read
    net_http_request.body = body unless body.empty?
    net_http_request
  end
end
