require 'rspec/expectations'

module Requests
  module ApiHelpers
    def app
      Rails.application
    end

    def json
      JSON.parse(last_response.body)
    end

    def json_env(env={})
      env.merge('CONTENT_TYPE' => 'application/json')
    end

    def json_params(params={})
      JSON.dump(params)
    end

    def api_get(path, params={}, env={}, *args)
      get path, json_params(params), json_env(env), *args
    end

    def api_post(path, params={}, env={}, *args)
      post path, json_params(params), json_env(env), *args
    end

    def api_patch(path, params={}, env={}, *args)
      patch path, json_params(params), json_env(env), *args
    end

    def api_put(path, params={}, env={}, *args)
      put path, json_params(params), json_env(env), *args
    end

    def api_delete(path, params={}, env={}, *args)
      delete path, json_params(params), json_env(env), *args
    end
  end
end

RSpec.configure do |config|
  config.include Requests::ApiHelpers, :type => :controller
end

RSpec::Matchers.define :be_successful do |expectation|
  match do |response|
    return false if response.status >= 400
    body = JSON.parse(response.body)
    return false if body.key? "exception"
    return false if body.key? "error"
    true
  end
  failure_message do |response|
    body = JSON.parse(response.body)
    "expected response status #{response.status} would be < 400\nrecieved error message \"#{body["error"] or body["exception"]}\""
  end
end
