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
    rescue Client::NotFoundError
      raise(InvalidHandleError, "Handle #{handle} was not found")
    end

    private

    attr_reader :github_client

    class InvalidHandleError < RuntimeError; end
  end
end
