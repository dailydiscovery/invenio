module Invenio
  class PullRequest
    attr_reader :user, :number, :client, :acceptable

    def initialize(options = {}, client = GitHub::Client.new)
      @user = options[:user]
      @number = options[:number]
      @client = client
      @acceptable = true
    end

    def review
      acceptable? ? merge : comment
    end

    def acceptable?
      files.each do |f|
        if f !~ /\Adiscoveries\/\d{8}\/#{user}_/
          @acceptable = false
          break
        end
      end

      @acceptable
    end

    def merge
      client.merge_pull_request number
    end

    def comment
      return if client.pull_request_bot_commented? number

      body = [
        "Sorry @#{user}, but your Pull Request isn't acceptable. :frowning:",
        "Please see [CONTRIBUTING.md](/dailydiscovery/dailydiscovery/blob/master/CONTRIBUTING.md) for guidelines on an acceptable Pull Request.",
        "Thank you! :smile:",
      ]
      client.add_pull_request_comment number, body.join("\n\n")
    end

    def files
      @files ||= client.pull_request_files number
    end
  end
end
