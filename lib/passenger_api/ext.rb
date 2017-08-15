# frozen_string_literal: true

unless defined?(PhusionPassenger)
  require 'phusion_passenger'
  PhusionPassenger.locate_directories
end
PhusionPassenger.require_passenger_lib 'config/api_call_command'

module PhusionPassenger
  module Config
    class ApiCallCommand
      private

      def print_headers(response)
        throw :response, response
      end
    end
  end
end
