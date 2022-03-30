require 'bundler/setup'
Bundler.require

module GithubScore
  class UserPublicEventList
    attr_reader :handle

    def initialize(handle, github_client = nil)
      @handle = handle
      @github_client = github_client || Client.new
    end

    def score
      EventScorer.score(to_a)
    end

    def to_a
      github_client.public_events(handle)
    end

    private

    attr_reader :github_client
  end

  class Client
    def public_events(handle)
      events_client.performed(handle).to_a
    end

    private

    def events_client
      @events_client ||= Github::Client::Activity::Events.new(auto_pagination: true)
    end
  end

  class EventScorer
    EVENT_SCORES = {
      'IssueEvent' => 1,
      'IssueCommentEvent' => 2,
      'PushEvent' => 3,
      'PullRequestReviewCommentEvent' => 4,
      'WatchEvent' => 5,
      'CreateEvent' => 6,
    }.freeze

    def self.score(events)
      events.sum { |event| EVENT_SCORES.fetch(event.type, 1) }
    end
  end
end

