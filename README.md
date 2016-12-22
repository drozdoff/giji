# Giji

Add some smart flow between JIRA and Github.

## Configuration

In order to use this app configure the following environment variables:
 * JIRA_USERNAME
 * JIRA_PASS
 * JIRA_BASE_URL 
 * JIRA_ISSUE_PATTERN - as regular expression
 
 * GITHUB_TOKEN - github OAuth token
 * GITHUB_REPOSITORY_NAME
 
 * MIN_APPROVES_REQUIRED - minimum PR approves to transition JIRA issue 
 
 _(should be quite self-explanatory, huh...)_
 
 
 ## TODO:
 - [ ] Replace Assignees with Reviewers
 - [ ] Handle editing reviewed PR for the case when JIRA tickets have been changed
 - [ ] Handle requesting review changes after PR has been approved
 - [ ] Provide a better way to handle transitions
 - [ ] Refactor and polish code
 - [ ] Add tests




