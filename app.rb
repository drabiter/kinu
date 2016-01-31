require "yaml"
require "terminal-table"

require_relative "./services/github_service"
require_relative "./modules/formatter_module"

config = YAML.load_file "config.yml"

github_service = GithubService.new config["access_token"]

merged_prs = github_service.find_merged_pull_request ARGV[0], ARGV[1]

rows = []
merged_prs.items.each do |pr|
  duration = Formatter.humanize pr.closed_at - pr.created_at
  rows << [pr.user.login, duration, pr.title]
  rows << :separator
end
table = Terminal::Table.new(:headings => ["Owner", "Lifetime", "Title"], :rows => rows)
puts table
