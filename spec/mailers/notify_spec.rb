require 'spec_helper'

describe Notify do
  include EmailSpec::Helpers
  include EmailSpec::Matchers

  before do
    @project = FactoryGirl.create :project
    @commit = FactoryGirl.create :commit, project: @project
    @build = FactoryGirl.create :build, commit: @commit
  end

  describe 'build success' do
    subject { described_class.build_success_email(@build.id, 'wow@example.com') }

    it 'has the correct subject' do
      is_expected.to have_subject /Build success for/
    end

    it 'contains name of project' do
      is_expected.to have_body_text /build successful/
    end
  end

  describe 'build fail' do
    subject { described_class.build_fail_email(@build.id, 'wow@example.com') }

    it 'has the correct subject' do
      is_expected.to have_subject /Build failed for/
    end

    it 'contains name of project' do
      is_expected.to have_body_text /build failed/
    end
  end
end
