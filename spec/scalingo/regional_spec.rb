require "spec_helper"

RSpec.describe Scalingo::Regional do
  subject { described_class.new("url") }

  %w[
    addons apps autoscalers collaborators containers deployments domains
    environment events logs metrics notifiers operations scm_repo_links
  ].each do |section|
    it "handles requests for #{section}" do
      expect(subject.respond_to?(section)).to be true
    end
  end
end
