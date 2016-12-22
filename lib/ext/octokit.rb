module Octokit
  class Client
    module Reviews
      def reviews(repo, number, options = {})
        paginate "#{Repository.path repo}/pulls/#{number}/reviews", options
      end

      def requested_reviewers(repo, number, options = {})
        paginate "#{Repository.path repo}/pulls/#{number}/requested_reviewers", options
      end
    end

    include Octokit::Client::Reviews
  end
end