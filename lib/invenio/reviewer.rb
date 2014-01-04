module Invenio
  class Reviewer

    attr_reader :client, :pull_requests

    def self.run
      reviewer = new
      reviewer.fetch
      reviewer.review
    end

    def initialize(client = GitHub::Client.new)
      @client = client
      @pull_requests = []
    end

    def fetch
      client.pull_requests.each do |pull_request|
        options = {}

        options[:user] = pull_request.user.login
        options[:number] = pull_request.number

        pull_requests << PullRequest.new(options)
      end
    end

    def review
      pull_requests.map(&:review)
    end
  end
end
