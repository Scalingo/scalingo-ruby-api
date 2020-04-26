# spec/support/fake_github.rb
require 'sinatra/base'

module Scalingo
  module Mocks
    module Auth
      VALID_ACCESS_TOKEN = "lala"
      VALID_BEARER_TOKEN = "the-bearer-token"
    end
  end
end

class Scalingo::Mocks::Auth::API < Sinatra::Base
  set :environment, :production
  set :dump_errors, false

  error Scalingo::Error::Unauthenticated do
    status 401
    content_type :json
    {error: "Unauthorized"}.to_json
  end

  helpers do
    def check_token!
      if request.env["HTTP_AUTHORIZATION"] != "Bearer #{Scalingo::Mocks::Auth::VALID_BEARER_TOKEN}"
        raise Scalingo::Error::Unauthenticated
      end
    end
  end

  post "/v1/tokens/exchange" do
    if !request.env["HTTP_AUTHORIZATION"].present?
      return json_response(request, code: 401, variant: :unauthorized)
    end

    _scheme, encoded = request.env["HTTP_AUTHORIZATION"].split(" ")
    _user, token = Base64.decode64(encoded).split(":")

    content_type :json

    if token == Scalingo::Mocks::Auth::VALID_ACCESS_TOKEN
      status 200

      return {token: Scalingo::Mocks::Auth::VALID_BEARER_TOKEN}.to_json
    else
      raise Scalingo::Error::Unauthenticated
    end
  end

  get "/v1/tokens" do
    check_token!

    json_response(request, :all)
  end

  post "/v1/tokens" do
    check_token!

    json_response(request, :create, code: 201)
  end

  patch "/v1/tokens/00ac4742-8ff5-4306-932f-3078e28ecaff/renew" do
    check_token!

    json_response(request, :renew)
  end

  delete "/v1/tokens/00ac4742-8ff5-4306-932f-3078e28ecaff" do
    check_token!

    json_response(request, :destroy, code: 204)
  end

  private

  def response_path(request, *parts, code: 200)
    file_name = parts.compact.join(".") + ".json"

    File.join(File.dirname(__FILE__), "v1", "tokens", file_name)
  end

  def json_response(request, *parts, code: 200)
    content_type :json
    status code

    path_to_sample = response_path(request, *parts, code: code)

    File.exists?(path_to_sample) ? File.open(path_to_sample).read : nil
  end
end
