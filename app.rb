require "yaml"
require "terminal-table"

require_relative "./services/github_service"
require_relative "./modules/formatter_module"
require_relative "./modules/worktime_module"

config = YAML.load_file "config.yml"

github_service = GithubService.new config["access_token"]

action = ARGV[0]

if action == "stat"
  merged_prs = github_service.find_merged_pull_request ARGV[1], ARGV[2]

  rows = []
  merged_prs.items.each do |pr|
    duration = Formatter.humanize pr.closed_at - pr.created_at
    review_time = WorktimeModule.trim_to_worktime pr.created_at, pr.closed_at
    rows << [pr.user.login, duration, review_time, pr.title]
    rows << :separator
  end
  table = Terminal::Table.new(:headings => ["Owner", "Lifetime", "Review time (work hours)", "Title"], :rows => rows)
  puts table
elsif action == "release"
  milestone = ARGV[1]

  merged_prs = github_service.find_merged_pull_request_milestone milestone
  open_prs = github_service.find_open_pull_request_milestone milestone

  merged_prs.items.each do |pr|
    puts "- [x] #{pr.title} [link](#{pr.html_url})"
  end
  open_prs.items.each do |pr|
    puts "- [ ] #{pr.title} [link](#{pr.html_url})"
  end
end

