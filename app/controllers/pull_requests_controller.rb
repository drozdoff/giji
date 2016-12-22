class PullRequestsController < ApplicationController
  def process_data
    puts webhook_action
    PullRequests::WebhookHandlerFactory.handle(webhook_action, params).process
  end

  private

  def webhook_action
    request.request_parameters['action']
  end
end