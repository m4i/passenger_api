# frozen_string_literal: true

require 'test_helper'

require 'json'
require 'rack/test'

class PassengerAPITest < Minitest::Test
  include Rack::Test::Methods

  NUMBER_OF_INSTANCES   = 3
  INSTANCE_REGISTRY_DIR = '/tmp/*'

  passengers = [PassengerHelper.start]
  NUMBER_OF_INSTANCES.times do
    passengers << PassengerHelper.start(INSTANCE_REGISTRY_DIR)
  end
  Minitest.after_run { passengers.each(&:stop) }

  def app
    Rack::Builder.new.run(PassengerAPI.new)
  end

  def test_that_it_has_a_version_number
    refute_nil ::PassengerAPI::VERSION
  end

  def test_ping_json
    get '/ping.json'
    assert_response(last_response).each do |response|
      assert_equal 200, response['status']
      assert_equal 'application/json', response['header']['Content-Type']
      body = JSON.parse(response['body'])
      assert_equal 'ok', body['status']
    end
  end

  def test_ping_json_with_passenger_instance_registry_dir
    header 'X-Passenger-Instance-Registry-Dir', INSTANCE_REGISTRY_DIR
    get '/ping.json'
    assert_response(last_response, NUMBER_OF_INSTANCES).each do |response|
      assert_equal 200, response['status']
      assert_equal 'application/json', response['header']['Content-Type']
      body = JSON.parse(response['body'])
      assert_equal 'ok', body['status']
    end
  end

  def test_ping_json_without_instance
    header 'X-Passenger-Instance-Registry-Dir', '/dummy'
    get '/ping.json'
    responses = assert_response(last_response, 0)
    assert_equal [], responses
  end

  def test_pool_txt
    get '/pool.txt'
    assert_response(last_response).each do |response|
      assert_equal 200, response['status']
      assert_equal 'text/plain', response['header']['Content-Type']
    end
  end

  def test_pool_xml
    get '/pool.xml'
    assert_response(last_response).each do |response|
      assert_equal 200, response['status']
      assert_equal 'text/xml', response['header']['Content-Type']
    end
  end

  def test_404
    get '/not_found'
    assert_response(last_response).each do |response|
      assert_equal 404, response['status']
    end
  end

  def test_405
    get '/pool/detach_process.json'
    assert_response(last_response).each do |response|
      assert_equal 405, response['status']
    end
  end

  private

  def assert_response(response, number_of_instances = 1)
    assert response.ok?
    assert_equal 'application/json', response.content_type
    responses = JSON.parse(response.body)
    assert_equal number_of_instances, responses.length
    responses
  end
end
