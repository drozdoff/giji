module PullRequests
  class ChangesHandler < PullRequests::Base

    def process
      context = 'Giji'

      if @pull_request.valid?
        status      = 'success'
        description = 'Everything is OK.'
      else
        status      = 'failure'
        description = 'Check this PR for required data.'
      end

      @pull_request.set_head_status!(status, { context: context, description: description })
    end

  end
end