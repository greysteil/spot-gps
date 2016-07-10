require 'spec_helper'

describe SPOT::ApiService do
  subject(:service) do
    described_class.new(feed_id: 'EXAMPLE_ID', feed_password: password)
  end
  let(:password) { nil }

  before do
    allow(SPOT).to receive(:endpoint).and_return('https://example.com/')
    stub_request(:get, /https:\/\/example\.com/).
      to_return(body: '{}', status: 200)
  end


  describe 'making a get request without any parameters' do
    it 'is expected to make a GET request to the correct URL' do
      service.get(path: 'messages.json')
      expect(WebMock).
        to have_requested(:get, 'https://example.com/EXAMPLE_ID/messages.json').
        with(query: {})
    end

    context 'with a password' do
      let(:password) { 'password' }

      it 'is expected to include the password in the querystring' do
        service.get(path: 'messages.json')
        expect(WebMock).
          to have_requested(:get, 'https://example.com/EXAMPLE_ID/messages.json').
          with(query: { feedPassword: 'password' })
      end
    end
  end

  describe 'making a get request with parameters' do
    it 'is expected to make a GET request to the correct URL' do
      service.get(path: 'messages.json', params: { example: 'param' })
      expect(WebMock).
        to have_requested(:get, 'https://example.com/EXAMPLE_ID/messages.json').
        with(query: { example: 'param' })
    end

    context 'with a password' do
      let(:password) { 'password' }

      it 'is expected to include the password in the querystring' do
        service.get(path: 'messages.json', params: { example: 'param' })
        expect(WebMock).
          to have_requested(:get, 'https://example.com/EXAMPLE_ID/messages.json').
          with(query: { feedPassword: 'password', example: 'param' })
      end
    end
  end
end
