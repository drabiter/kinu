require "octokit"

class GithubService

  def initialize(access_token)
    @access_token = access_token
    @client = Octokit::Client.new(:access_token => @access_token)
  end

  def find_merged_pull_request(start_date, end_date)
    @client.search_issues "repo:veritrans/payment-api is:pr is:merged created:#{start_date}..#{end_date}", :order => "desc"
  end

  def find_merged_pull_request_milestone(milestone)
    @client.search_issues "repo:veritrans/payment-api is:pr is:merged milestone:#{milestone}"
  end

  def find_open_pull_request_milestone(milestone)
    @client.search_issues "repo:veritrans/payment-api is:pr is:open milestone:#{milestone}"
  end

end
