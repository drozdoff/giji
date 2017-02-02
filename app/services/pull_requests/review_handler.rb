module PullRequests
  class ReviewHandler < PullRequests::Base

    def process
      if @pull_request.valid? && @pull_request.approved? && !@pull_request.has_skip_token?
        puts 'PR is good to go'
        @pull_request.jira_issues.each do |issue_key|
          issue = JiraIssue.new(issue_key)
          issue.transition!(:ready_for_qa)
          puts 'Transition done'
        end
        @pull_request.set_approved_label!
      end
    end

  end
end