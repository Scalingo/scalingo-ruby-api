require "spec_helper"

RSpec.describe Scalingo::Billing do
  subject { described_class.new(:client, "url") }

  %w[profile].each do |section|
    it "handles requests for #{section}" do
      expect(subject.respond_to?(section)).to be true
    end
  end
end
