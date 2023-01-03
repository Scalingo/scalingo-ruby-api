require "spec_helper"

RSpec.describe Scalingo::CoreClient do
  subject { described_class.new }

  describe "#database_region" do
    it "forwards call to the specified region" do
      allow(subject).to receive("db_api_osc_secnum_fr1")

      subject.database_region("db_api_osc_secnum_fr1")

      expect(subject).to have_received("db_api_osc_secnum_fr1")
    end

    it "forwards call to default db_api region" do
      allow(subject).to receive("db_api_#{subject.config.default_region}")

      subject.database_region

      expect(subject).to have_received("db_api_#{subject.config.default_region}")
    end
  end
end
