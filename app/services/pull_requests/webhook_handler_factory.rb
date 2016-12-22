module PullRequests
  class WebhookHandlerFactory
    def self.handle(action, payload)
      case action
      when 'opened', 'reopened', 'edited', 'assigned', 'unassigned', 'synchronize'
        PullRequests::ChangesHandler.new(payload)
      when 'submitted'
        PullRequests::ReviewHandler.new(payload)
      end
    end
  end
end