class PullRequest

  def initialize(number, title, body, head, assignees)
    @number = number
    @title = title
    @body = body
    @head = head
    @assignees = assignees
  end

  def add_jira_issue_links!
    links = []
    @body += "\n"
    jira_issues.each do |issue_key|
      link = generate_jira_issue_link(issue_key)
      unless @body.scan(link).present?
        links << link
        @body += "\n#{link}"
      end
    end

    if links.present?
      Octokit.update_pull_request(ENV['GITHUB_REPOSITORY_NAME'], @number, { body: @body })
    end
  end

  def set_head_status!(status, info = {})
    Octokit.create_status(ENV['GITHUB_REPOSITORY_NAME'], @head, status, info)
  end

  def reviews
    @reviews ||= Octokit.reviews(ENV['GITHUB_REPOSITORY_NAME'], @number)
  end

  def jira_issues
    @jira_issues ||= extract_jira_issues
  end

  def valid?
    jira_issues.present? && @assignees.size >= 2
  end

  def approved?
    reviews_grouped_by_user = reviews.map { |review| { user_id: review.user.id, state: review.state, submitted_at: review.submitted_at } }
                                  .sort { |a, b| a[:submitted_at] <=> b[:submitted_at] }
                                  .group_by { |el| el[:user_id] }
                                  .values

    approved_reviews_count = 0

    reviews_grouped_by_user.each do |reviews|
      approved = reviews.last[:state].downcase == 'approved'
      approved_reviews_count += 1 if approved
    end

    approved_reviews_count + 1 >= ENV['MIN_APPROVES_REQUIRED'].to_i
  end

  private

  def extract_jira_issues
    issue_regex = Regexp.new(ENV['JIRA_ISSUE_PATTERN'])
    (@title.scan(issue_regex) + @body.scan(issue_regex)).compact.uniq
  end

  def generate_jira_issue_link(issue_key)
    "#{ENV['JIRA_BASE_URL']}/browse/#{issue_key}"
  end
end