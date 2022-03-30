module GithubScore
  RSpec.describe(UserPublicEventList) do
    describe 'score' do
      subject(:score) { described_class.new(handle, github_client).score }

      let(:handle) { 'tenderlove' }
      let(:github_client) { instance_double('GithubScore::Client', public_events: events) }
      let(:events) { events_from_types(%w[IssuesEvent CreateEvent]) }

      it 'returns the total score of the users public event list' do
        expect(score).to eq(7)
      end

      context 'when the handle does not exist' do
        it 'raises an error' do
          allow(github_client).to receive(:public_events).and_raise(Client::NotFoundError)

          expect { score }.to raise_error(described_class::InvalidHandleError)
        end
      end

      def events_from_types(event_types)
        event_types.map { |type| double(type: type) }
      end
    end
  end
end
