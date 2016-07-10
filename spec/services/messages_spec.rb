require 'spec_helper'

describe SPOT::Services::Messages do
  let(:messages) { SPOT::API.new(feed_id: 'EXAMPLE_ID').messages }

  describe "#all" do
    subject(:all) { messages.all(args) }
    context "without any arguments" do
      let(:args) { {} }

      it "makes a request without any querystring params" do
        expect_any_instance_of(SPOT::ApiService).
          to receive(:get).
          with(path: 'message.json', params: {})

        messages.all
      end
    end

    context "with a page parameter" do
      context "that is invalid" do
        let(:args) { { page: "invalid" } }
        specify { expect { all }.to raise_error(ArgumentError) }
      end

      context "that is zero" do
        let(:args) { { page: 0 } }
        specify { expect { all }.to raise_error(ArgumentError) }
      end

      context "that is greater than zero" do
        let(:args) { { page: 1 } }

        it "makes a request with a start param" do
          expect_any_instance_of(SPOT::ApiService).
            to receive(:get).
            with(path: 'message.json', params: { start: 0 })

          all
        end

        context "and greater than 1" do
          let(:args) { { page: 2 } }

          it "increases the start param by multiples of 50" do
            expect_any_instance_of(SPOT::ApiService).
              to receive(:get).
              with(path: 'message.json', params: { start: 50 })

            all
          end
        end
      end
    end

    context "with a start_at or end_at parameter" do
      context "that is invalid" do
        let(:args) { { start_at: "invalid" } }
        specify { expect { all }.to raise_error(ArgumentError) }
      end

      context "that is a valid string" do
        let(:args) { { start_at: "2016-01-01", end_at: "2016-02-01" } }

        it "makes a request with a startDate param" do
          expect_any_instance_of(SPOT::ApiService).
            to receive(:get).
            with(path: 'message.json',
                 params: { startDate: '2016-01-01T00:00:00-0000',
                           endDate: '2016-02-01T00:00:00-0000' })

          all
        end
      end

      context "that is a Date" do
        let(:args) { { start_at: Date.parse('2016-01-01') } }

        it "makes a request with a startDate param" do
          expect_any_instance_of(SPOT::ApiService).
            to receive(:get).
            with(path: 'message.json',
                 params: { startDate: '2016-01-01T00:00:00-0000' })

          all
        end
      end

      context "that is a DateTime" do
        let(:args) { { start_at: DateTime.parse('2016-01-01') } }

        it "makes a request with a startDate param" do
          expect_any_instance_of(SPOT::ApiService).
            to receive(:get).
            with(path: 'message.json',
                 params: { startDate: '2016-01-01T00:00:00-0000' })

          all
        end
      end

      context "that is a Time" do
        let(:args) { { start_at: Time.parse('2016-01-01') } }

        it "makes a request with a startDate param" do
          expect_any_instance_of(SPOT::ApiService).
            to receive(:get).
            with(path: 'message.json',
                 params: { startDate: '2016-01-01T00:00:00-0000' })

          all
        end
      end
    end
  end

  describe "#latest" do
    it "makes a request for the `latest.json` path, without params" do
      expect_any_instance_of(SPOT::ApiService).
        to receive(:get).
        with(path: 'latest.json')

      messages.latest
    end
  end
end
