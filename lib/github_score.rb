require 'bundler/setup'
Bundler.require

module GithubScore
  require 'github_score/cli'
  require 'github_score/client'
  require 'github_score/event_scorer'
  require 'github_score/user_public_event_list'
end
