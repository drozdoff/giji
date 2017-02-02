class PullRequestsController < ApplicationController
  def process_data
    puts webhook_action
    handler = PullRequests::WebhookHandlerFactory.handle(webhook_action, params)
    handler.process if handler
  end

  private

  def webhook_action
    request.request_parameters['action']
  end
end