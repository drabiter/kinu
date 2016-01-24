require "yaml"

require_relative "./services/github_service"
require_relative "./modules/formatter_module"

config = YAML.load_file "config.yml"

github_service = GithubService.new config["access_token"]

merged_prs = github_service.find_merged_pull_request ARGV[0], ARGV[1]

p "#{'%-12s' % 'owner'} #{'%-40s' % 'duration'} - title"
merged_prs.items.each do |pr|
  duration = Formatter.humanize pr.closed_at - pr.created_at
  p "[#{'%-10s' % pr.user.login}] [#{'%-38s' % duration}] - #{pr.title}"
end
