require 'spec_helper'

describe SPOT::Services::Messages do
  let(:messages) { SPOT::Client.new(feed_id: 'EXAMPLE_ID').messages }

  describe "#all" do
    subject(:all) { messages.all(args) }
    let(:args) { {} }

    it { is_expected.to be_a(Enumerator) }

    context "with records" do
      before do
        stub_url = SPOT.endpoint + 'EXAMPLE_ID/message.json'
        stub_request(:get, stub_url).to_return(
          body: load_fixture('message.json'),
          headers: { 'Content-Type' => 'application/json' }
        )

        stub_request(:get, stub_url + "?start=50").to_return(
          body: load_fixture('message.json'),
          headers: { 'Content-Type' => 'application/json' }
        )

        stub_request(:get, stub_url + "?start=100").to_return(
          body: load_fixture('no_messages.json'),
          headers: { 'Content-Type' => 'application/json' }
        )
      end

      its(:first) { is_expected.to be_a(SPOT::Resources::Message) }
      its("to_a.length") { is_expected.to eq(4) }

      it "makes the correct number of requests" do
        all.map(&:created_at).to_a
        expect(a_request(:get, /#{Regexp.quote(SPOT.endpoint)}/)).
          to have_been_made.times(3)
      end
    end

    context "with no records" do
      before do
        stub_url = SPOT.endpoint + 'EXAMPLE_ID/message.json'
        stub_request(:get, stub_url).to_return(
          body: load_fixture('no_messages.json'),
          headers: { 'Content-Type' => 'application/json' }
        )
      end

      its(:first) { is_expected.to eq(nil) }
      its("to_a.length") { is_expected.to eq(0) }
    end
  end

  describe "#list" do
    subject(:list) { messages.list(args) }

    before do
      stub_url = SPOT.endpoint + 'EXAMPLE_ID/message.json'
      stub_request(:get, /#{Regexp.escape(stub_url)}.*/).to_return(
        body: load_fixture('message.json'),
        headers: { 'Content-Type' => 'application/json' }
      )
    end

    context "without any arguments" do
      let(:args) { {} }

      it "makes a request without any querystring params" do
        expect_any_instance_of(SPOT::ApiService).
          to receive(:get).
          with(path: 'message.json', params: {}).
          and_call_original

        messages.list
      end

      it { is_expected.to be_a(SPOT::ListResponse) }
      its(:response) { is_expected.to be_a(SPOT::ApiResponse) }
      its("records.first") { is_expected.to be_a(SPOT::Resources::Message) }

      context "when there are no displayable messages" do
        before do
          stub_url = SPOT.endpoint + 'EXAMPLE_ID/message.json'
          stub_request(:get, /#{Regexp.escape(stub_url)}.*/).to_return(
            body: load_fixture('no_messages.json'),
            headers: { 'Content-Type' => 'application/json' }
          )
        end

        it { is_expected.to be_a(SPOT::ListResponse) }
        its(:records) { is_expected.to eq([]) }
      end
    end

    context "with a page parameter" do
      context "that is invalid" do
        let(:args) { { page: "invalid" } }
        specify { expect { list }.to raise_error(ArgumentError) }
      end

      context "that is zero" do
        let(:args) { { page: 0 } }
        specify { expect { list }.to raise_error(ArgumentError) }
      end

      context "that is greater than zero" do
        let(:args) { { page: 1 } }

        it "makes a request with a start param" do
          expect_any_instance_of(SPOT::ApiService).
            to receive(:get).
            with(path: 'message.json', params: { start: 0 }).
            and_call_original

          list
        end

        context "and greater than 1" do
          let(:args) { { page: 2 } }

          it "increases the start param by multiples of 50" do
            expect_any_instance_of(SPOT::ApiService).
              to receive(:get).
              with(path: 'message.json', params: { start: 50 }).
              and_call_original

            list
          end
        end
      end
    end

    context "with a start_at or end_at parameter" do
      context "that is invalid" do
        let(:args) { { start_at: "invalid" } }
        specify { expect { list }.to raise_error(ArgumentError) }
      end

      context "that is a valid string" do
        let(:args) { { start_at: "2016-01-01", end_at: "2016-02-01" } }

        it "makes a request with a startDate param" do
          expect_any_instance_of(SPOT::ApiService).
            to receive(:get).
            with(path: 'message.json',
                 params: { startDate: '2016-01-01T00:00:00-0000',
                           endDate: '2016-02-01T00:00:00-0000' }).
            and_call_original

          list
        end
      end

      context "that is a Date" do
        let(:args) { { start_at: Date.parse('2016-01-01') } }

        it "makes a request with a startDate param" do
          expect_any_instance_of(SPOT::ApiService).
            to receive(:get).
            with(path: 'message.json',
                 params: { startDate: '2016-01-01T00:00:00-0000' }).
            and_call_original

          list
        end
      end

      context "that is a DateTime" do
        let(:args) { { start_at: DateTime.parse('2016-01-01') } }

        it "makes a request with a startDate param" do
          expect_any_instance_of(SPOT::ApiService).
            to receive(:get).
            with(path: 'message.json',
                 params: { startDate: '2016-01-01T00:00:00-0000' }).
            and_call_original

          list
        end
      end

      context "that is a Time" do
        let(:args) { { start_at: Time.parse('2016-01-01') } }

        it "makes a request with a startDate param" do
          expect_any_instance_of(SPOT::ApiService).
            to receive(:get).
            with(path: 'message.json',
                 params: { startDate: '2016-01-01T00:00:00-0000' }).
            and_call_original

          list
        end
      end
    end
  end

  describe "#latest" do
    subject { messages.latest }
    before do
      stub_url = SPOT.endpoint + 'EXAMPLE_ID/latest.json'
      stub_request(:get, stub_url).to_return(
        body: load_fixture('latest.json'),
        headers: { 'Content-Type' => 'application/json' }
      )
    end

    it "makes a request for the `latest.json` path, without params" do
      expect_any_instance_of(SPOT::ApiService).
        to receive(:get).
        with(path: 'latest.json').
        and_call_original

      messages.latest
    end

    it { is_expected.to be_a(SPOT::Resources::Message) }
    its(:response) { is_expected.to be_a(SPOT::ApiResponse) }

    context "with no records" do
      before do
        stub_url = SPOT.endpoint + 'EXAMPLE_ID/latest.json'
        stub_request(:get, stub_url).to_return(
          body: load_fixture('no_messages.json'),
          headers: { 'Content-Type' => 'application/json' }
        )
      end

      it { is_expected.to be_nil }
    end
  end
end
