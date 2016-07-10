require 'spec_helper'

describe SPOT::ApiResponse do
  subject(:response) { described_class.new(raw_response) }

  let(:raw_response) do
    stub_url = SPOT.endpoint + 'EXAMPLE_ID/message.json'
    stub_request(:get, /#{Regexp.escape(stub_url)}.*/).to_return(
      body: load_fixture('message.json'),
      headers: { 'Content-Type' => 'application/json' }
    )

    RestClient::Request.execute(
      url: stub_url,
      method: :get,
      headers: { 'Content-Type' => 'application/json' }
    )
  end

  describe "#body" do
    context "when the response is JSON" do
      it 'returns the body parsed into a hash' do
        expect(response.body).to be_a(Hash)
      end
    end

    context "when the response isn't JSON" do
      let(:raw_response) do
        stub_url = SPOT.endpoint + 'EXAMPLE_ID/message.json'
        stub_request(:get, /#{Regexp.escape(stub_url)}.*/).to_return(
          body: 'Bad body',
          headers: { 'Content-Type' => 'application/xml' }
        )

        RestClient::Request.execute(
          url: stub_url,
          method: :get,
          headers: { 'Content-Type' => 'application/xml' }
        )
      end

      it 'raises an error' do
        expect { response.body }.to raise_error(RuntimeError)
      end
    end
  end
end
