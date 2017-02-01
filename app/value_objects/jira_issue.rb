class JiraIssue

  TRANSITION_MAPPINGS = {
      in_progress: 11,
      in_review: 151,
      reject: 51,
      ready_for_qa: 21,
      review_to_ready: 141,
      reopen_to_progress: 221
  }

  def initialize(key)
    @key = key
  end

  def current_status
    @current_status ||= external_issue.status.id
  end

  def transition!(status)
    puts status
    transition = external_issue.transitions.build
    if status == :ready_for_qa
      case current_status
      when '3'
        transition.save!({'transition' => { 'id' => TRANSITION_MAPPINGS[:ready_for_qa] } })
      when '10205'
        transition.save!({'transition' => { 'id' => TRANSITION_MAPPINGS[:review_to_ready] } })
      when '10000'
        transition.save!({'transition' => { 'id' => TRANSITION_MAPPINGS[:in_progress] } })
        transition = external_issue.transitions.build
        transition.save!({'transition' => { 'id' => TRANSITION_MAPPINGS[:ready_for_qa] } })
      when '4'
        transition.save!({'transition' => { 'id' => TRANSITION_MAPPINGS[:reopen_to_progress] } })
        transition = external_issue.transitions.build
        transition.save!({'transition' => { 'id' => TRANSITION_MAPPINGS[:ready_for_qa] } })
      end
    else
      transition.save!({'transition' => { 'id' => TRANSITION_MAPPINGS[:reject] } })
      transition = external_issue.transitions.build
      transition.save!({'transition' => { 'id' => TRANSITION_MAPPINGS[:in_review] } })
    end
  end

  private

  def client
    @client ||= JIRA::Client.new(username:     ENV['JIRA_USERNAME'],
                                 password:     ENV['JIRA_PASS'],
                                 site:         ENV['JIRA_BASE_URL'],
                                 context_path: '',
                                 auth_type:    :basic)
  end

  def external_issue
    @external_issue ||= client.Issue.find(@key)
  end
end