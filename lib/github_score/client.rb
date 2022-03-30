module GithubScore
  class Client
    def public_events(handle)
      events_client.performed(handle, public: true).to_a
    rescue Github::Error::NotFound => e
      raise(NotFoundError, e)
    end

    private

    def events_client
      @events_client ||= Github::Client::Activity::Events.new(auto_pagination: true)
    end

    class NotFoundError < RuntimeError; end
  end
end
