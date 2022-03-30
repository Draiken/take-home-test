require 'bundler/setup'
Bundler.require

module GithubScore
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

