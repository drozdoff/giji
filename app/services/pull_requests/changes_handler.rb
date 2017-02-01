module PullRequests
  class ChangesHandler < PullRequests::Base

    def process
      context = 'Giji'

      if @pull_request.valid?
        status      = 'success'
        description = '2 assignees ✓, JIRA task key ✓'
      else
        status      = 'failure'
        description = 'Add assignees and/or JIRA task key.'
      end

      @pull_request.set_head_status!(status, { context: context, description: description })
    end

  end
end