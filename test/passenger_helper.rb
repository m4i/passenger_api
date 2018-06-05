# frozen_string_literal: true

require 'fileutils'
require 'socket'
require 'timeout'

class PassengerHelper
  class << self
    def start(instance_registry_dir = '/tmp')
      new(instance_registry_dir).tap(&:start)
    end
  end

  def initialize(instance_registry_dir)
    @instance_registry_dir = instance_registry_dir.gsub('*') { rand.to_s[2, 8] }
  end

  def start
    FileUtils.mkdir_p(@instance_registry_dir)
    @port ||= unused_port
    spawn(*%W[
            passenger start
            --port #@port
            --instance-registry-dir #@instance_registry_dir
            --daemonize
            --log-file /dev/null
          ])
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
