module GithubScore
  class Cli
    USAGE = -'Usage: gh_score USERNAME'

    def initialize(argv)
      @argv = argv
    end

    def run
      parse_args
      puts("Total score for user #{handle}\n#{score}")
    end

    private

    attr_reader :handle

    def parse_args
      @handle = @argv.first
      return if handle && handle != ""

      abort(USAGE)
    end

    def score
      user_public_event_list.score
    end

    def user_public_event_list
      GithubScore::UserPublicEventList.new(handle)
    end
  end
end
