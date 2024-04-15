require "spec_helper"

RSpec.describe Scalingo::Database do
  subject { described_class.new("url") }

  %w[databases backups].each do |section|
    it "handles requests for #{section}" do
      expect(subject.respond_to?(section)).to be true
    end
  end
end
