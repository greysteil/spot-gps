require 'spec_helper'

describe SPOT::Client do
  subject(:api) { described_class.new(options) }
  let(:options) { { feed_id: feed_id, feed_password: password } }
  let(:feed_id) { "EXAMPLE_ID" }
  let(:password) { nil }

  describe ".new" do
    subject { -> { described_class.new(options) } }

    context 'when initialised without a feed ID' do
      let(:feed_id) { nil }
      it { is_expected.to raise_error('feed_id is required') }
    end

    context 'when initialised without a password' do
      let(:password) { nil }
      it { is_expected.to_not raise_error }
    end
  end

  describe "#messages" do
    subject { api.messages }

    it { is_expected.to be_an_instance_of(SPOT::Services::Messages) }
  end
end
