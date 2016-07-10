require 'spec_helper'

describe SPOT::Resources::Message do
  describe 'initialising' do
    let(:data) do
      {
        '@clientUnixTime' => '0',
        'id' => 585079373,
        'messengerId' => '0-1234567',
        'messengerName' => 'My SPOT',
        'unixTime' => 1468164566,
        'messageType' => 'OK',
        'latitude' => 61.54875,
        'longitude' => -3.0697,
        'modelId' => 'SPOT3',
        'showCustomMsg' => 'Y',
        'dateTime' => '2016-07-10T15:29:26+0000',
        'batteryState' => 'GOOD',
        'hidden' => 0,
        'messageContent' => 'Example SPOT message.'
      }
    end

    it 'can be initialized from an unenveloped response' do
      resource = described_class.new(data, nil)

      expect(resource.id).to eq(585079373)
      expect(resource.created_at).to eq(Time.at(1468164566))
      expect(resource.type).to eq('OK')
      expect(resource.latitude).to eq(61.54875)
      expect(resource.longitude).to eq(-3.0697)
      expect(resource.battery_state).to eq('GOOD')
      expect(resource.hidden).to eq(false)
      expect(resource.show_custom_message).to eq(true)
      expect(resource.content).to eq('Example SPOT message.')
      expect(resource.messenger_id).to eq('0-1234567')
      expect(resource.messenger_name).to eq('My SPOT')
      expect(resource.messenger_model).to eq('SPOT3')
    end

    it 'can handle new attributes without erroring' do
      data['foo'] = 'bar'
      expect { described_class.new(data, nil) }.to_not raise_error
    end

    describe '#to_h' do
      subject { described_class.new(data, nil).to_h }
      it { is_expected.to eq(data) }
    end

    describe '#response' do
      subject { described_class.new(data, "response").response }
      it { is_expected.to eq("response") }
    end
  end
end
