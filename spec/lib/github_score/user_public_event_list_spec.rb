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

      def events_from_types(event_types)
        event_types.map { |type| double(type: type) }
      end
    end
  end
end
