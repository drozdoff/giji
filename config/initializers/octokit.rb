require 'ext/octokit'

Octokit.configure do |c|
  c.access_token = ENV['GITHUB_TOKEN']
end

Octokit.default_media_type = 'application/vnd.github.black-cat-preview+json'

