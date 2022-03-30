module GithubScore
  RSpec.describe(EventScorer) do
    describe 'event scoring' do
      it 'sums all the event scores based on type' do
        event_types = %w[IssuesEvent CreateEvent]
        events = events_from_types(event_types)
        expect(described_class.score(events)).to eq(7)

        event_types = %w[IssuesEvent IssuesEvent IssuesEvent IssuesEvent IssuesEvent WatchEvent]
        events = events_from_types(event_types)
        expect(described_class.score(events)).to eq(10)
      end

      def events_from_types(event_types)
        event_types.map { |type| double(type: type) }
      end
    end
  end
end
