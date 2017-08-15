# frozen_string_literal: true

require 'test_helper'

require 'json'
require 'rack/test'

class PassengerAPITest < Minitest::Test
  include Rack::Test::Methods

  passenger = PassengerHelper.start
  Minitest.after_run { passenger.stop }

  def app
    Rack::Builder.new.run(PassengerAPI.new)
  end

  def test_that_it_has_a_version_number
    refute_nil ::PassengerAPI::VERSION
  end

  def test_ping_json
    get '/ping.json'
    assert last_response.ok?
    assert_equal 'application/json', last_response.content_type
    data = JSON.parse(last_response.body)
    assert_equal 'ok', data['status']
  end

  def test_pool_txt
    get '/pool.txt'
    assert last_response.ok?
    assert_equal 'text/plain', last_response.content_type
  end

  def test_pool_xml
    get '/pool.xml'
    assert last_response.ok?
    assert_equal 'text/xml', last_response.content_type
  end

  def test_404
    get '/not_found'
    assert 404, last_response.status
  end

  def test_405
    get '/pool/detach_process.json'
    assert 405, last_response.status
  end
end
