# frozen_string_literal: true

class PassengerAPI
  class Request
    def initialize(env)
      @env = env
    end

    def method
      @env['REQUEST_METHOD']
    end

    def path
      path = @env['PATH_INFO']
      path = '/' if path.empty?
      path += "?#{@env['QUERY_STRING']}" unless @env['QUERY_STRING'].empty?
      path
    end

    def body
      @_body ||= @env['rack.input'].read
    end
  end
end
