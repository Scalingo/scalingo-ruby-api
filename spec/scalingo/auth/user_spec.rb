require "spec_helper"

RSpec.describe Scalingo::Auth::User, type: :endpoint do
  describe "self" do
    subject(:response) { instance.self(**arguments) }

    include_examples "requires authentication"

    it { is_expected.to have_requested(:get, api_path.merge("/users/self")) }
  end

  describe "update" do
    subject(:response) { instance.update(**arguments) }

    let(:body) { {field: "value"} }

    include_examples "requires authentication"

    it { is_expected.to have_requested(:put, api_path.merge("/users/account")).with(body: {user: body}) }
  end

  describe "stop free trial" do
    subject(:response) { instance.stop_free_trial(**arguments) }

    include_examples "requires authentication"

    it { is_expected.to have_requested(:post, api_path.merge("/users/stop_free_trial")) }
  end
end
