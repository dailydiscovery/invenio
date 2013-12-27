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
    end

    def review
    end
  end
end
