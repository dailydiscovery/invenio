require "test_helper"

class Invenio::PullRequestTest < MiniTest::Unit::TestCase
  def setup
    @user = "simeonwillbanks"
    @number = 1
    @files = ["discoveries/20131221/simeonwillbanks_a-good-discovery.md"]
    @bad_files = @files + ["20131221/a-bad-discovery.md"]
    @options = {
      :user => @user,
      :number => @number
    }
    @client = MiniTest::Mock.new
    @klass = Invenio::PullRequest
  end

  def test_can_accept_with_good_files
    @client.expect :pull_request_files, @files, [@number]

    pull_request = @klass.new @options, @client
    assert pull_request.acceptable?
    assert @client.verify
  end

  def test_cant_accept_with_bad_files
    @client.expect :pull_request_files, @bad_files, [@number]

    pull_request = @klass.new @options, @client
    refute pull_request.acceptable?
    assert @client.verify
  end

  def test_merge_when_acceptable
    @client.expect :pull_request_files, @files, [@number]
    @client.expect :merge_pull_request, nil, [@number]

    pull_request = @klass.new @options, @client
    pull_request.review
    assert @client.verify
  end

  def test_comment_when_not_acceptable
    @client.expect :pull_request_files, @bad_files, [@number]
    @client.expect :pull_request_bot_commented?, false, [@number]
    @client.expect :add_pull_request_comment, nil, [@number, String]

    pull_request = @klass.new @options, @client
    pull_request.review
    assert @client.verify
  end

  def test_dont_comment_when_not_acceptable_but_already_commented
    @client.expect :pull_request_files, @bad_files, [@number]
    @client.expect :pull_request_bot_commented?, true, [@number]
    # should not receive
    @client.expect :add_pull_request_comment, nil

    pull_request = @klass.new @options, @client
    pull_request.review
    # assert should not receive
    assert_raises MockExpectationError, "expected add_pull_request_comment" do
      @client.verify
    end
  end
end
