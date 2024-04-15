require "spec_helper"

RSpec.describe Scalingo::TokenHolder do
  subject(:token_holder_dummy_class) do
    Class.new {
      include(Scalingo::TokenHolder)
      attr_accessor :config
    }
  end

  describe "#token=" do
    subject { token_holder.token = token }

    let(:token_holder) do
      holder = token_holder_dummy_class.new
      holder.config = Scalingo::Configuration.new

      holder
    end

    context "without expiration date" do
      let(:token) { Scalingo.generate_test_jwt }

      it "set the auth token" do
        expect(token_holder.authenticated?).to be false
        subject
        expect(token_holder.authenticated?).to be true
      end
    end

    context "with an expiration date" do
      let(:token) { Scalingo.generate_test_jwt(duration: 1.hour) }

      it "refresh the auth token" do
        token_holder.token = token
        expect(token_holder.authenticated?).to be true

        travel_to(Time.current + 2.hours) do
          expect(token_holder.authenticated?).to be false
        end
      end
    end
  end
end
