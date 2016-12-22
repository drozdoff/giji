module PullRequests
  class ReviewHandler < PullRequests::Base

    def process
      if @pull_request.valid? && @pull_request.approved?
        @pull_request.jira_issues.each do |issue_key|
          issue = JiraIssue.new(issue_key)
          issue.transition!(:ready_for_qa)
        end
      end
    end

  end
end