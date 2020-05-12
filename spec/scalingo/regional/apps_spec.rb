require "spec_helper"

RSpec.describe Scalingo::Regional::Apps do
  let(:endpoint) { regional.apps }

  context "all" do
    let(:response) { endpoint.all }
    let(:expected_count) { 2 }
    let(:stub_pattern) { "all" }

    it_behaves_like "a collection response"
    it_behaves_like "a non-paginated collection"
  end

  context "create" do
    let(:response) { endpoint.create(name: "example-app") }

    context "success" do
      let(:stub_pattern) { "create-201" }

      it_behaves_like "a successful response", 201
    end

    context "success" do
      let(:stub_pattern) { "create-422" }

      it_behaves_like "an unprocessable request"
    end
  end

  context "find" do
    let(:response) { endpoint.find("51e938266edff4fac9100005") }

    context "success" do
      let(:stub_pattern) { "find-200" }

      it_behaves_like "a successful response"
    end

    context "not found" do
      let(:stub_pattern) { "find-404" }

      it_behaves_like "a not found response"
    end
  end

  # context "destroy" do
  #   let(:response) { endpoint.destroy("54dcde4a54636101231a0000") }

  #   context "success" do
  #     let(:stub_pattern) { "delete-204" }

  #     it_behaves_like "a successful response", 204
  #   end

  #   context "not found" do
  #     let(:stub_pattern) { "delete-404" }

  #     it_behaves_like "a not found response"
  #   end
  # end
end
