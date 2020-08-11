require "spec_helper"

RSpec.describe Scalingo::Auth do
  subject { described_class.new("url") }

  %w[keys scm_integrations tokens two_factor_auth user].each do |section|
    it "handles requests for #{section}" do
      expect(subject.respond_to?(section)).to be true
    end
  end

  it "aliases tfa" do
    expect(subject.tfa).to eq(subject.two_factor_auth)
  end
end
