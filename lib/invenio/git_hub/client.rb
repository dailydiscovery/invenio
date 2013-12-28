require "octokit"

module Invenio
  module GitHub
    class Client

      def pull_requests
        client.pull_requests GitHub::REPO
      end

      def merge_pull_request(number)
        client.merge_pull_request GitHub::REPO, number
      end

      def add_pull_request_comment(number, body)
        client.add_comment GitHub::REPO, number, body
      end

      def pull_request_files(number)
        client.pull_request_files(GitHub::REPO, number).map(&:filename)
      end

      def pull_request_bot_commented?(number)
        !!client.issue_comments(GitHub::REPO, number).index{ |c| c.user.login == GitHub::LOGIN }
      end

      def client
        @client ||= ::Octokit::Client.new :access_token => GitHub::ACCESS_TOKEN
      end
    end
  end
end
