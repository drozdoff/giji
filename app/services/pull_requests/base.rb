module PullRequests
  class Base
    def initialize(payload)
      raise PullRequests::InvalidPayloadException unless payload['pull_request']
      attrs = payload['pull_request']
      review = payload['review']
      @pull_request = ::PullRequest.new(attrs['number'],
                                        attrs['title'],
                                        attrs['body'],
                                        attrs['head']['sha'],
                                        attrs['assignees'],
                                        review
      )
    end
  end
end