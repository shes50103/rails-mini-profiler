# frozen_string_literal: true

module RailsMiniProfiler
  class RequestWrapper
    attr_reader :body,
                :method,
                :path,
                :query_string,
                :env

    def initialize(env = {})
      @env = env
      @method = @env['REQUEST_METHOD'] || 'GET'
      @query_string = @env['QUERY_STRING'] || ''
      @path = @env['PATH_INFO'] || '/'
      @body = read_body
    end

    def headers
      @env.select { |k, _v| k.start_with? 'HTTP_' } || []
    end

    private

    def read_body
      return '' unless @env['rack.input']

      body = @env['rack.input'].read
      @env['rack.input'].rewind
      body
    end
  end
end
