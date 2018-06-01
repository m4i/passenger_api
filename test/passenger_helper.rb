# frozen_string_literal: true

require 'socket'
require 'timeout'

class PassengerHelper
  class << self
    def start
      new.tap(&:start)
    end
  end

  def initialize
    @port = unused_port
  end

  def start
    spawn(*%W[passenger start --port #@port --daemonize --log-file /dev/null])
    Timeout.timeout(60) { wait_for_started }
  end

  def stop
    system(*%W[passenger stop --port #@port])
  end

  private

  def unused_port
    server = TCPServer.open(0)
    begin
      server.addr[1]
    ensure
      server.close
    end
  end

  def wait_for_started
    TCPSocket.open('localhost', @port).close
    sleep 1
  rescue SystemCallError
    sleep 0.1
    retry
  end
end
