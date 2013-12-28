require "invenio/version"
require "invenio/reviewer"
require "invenio/git_hub"
require "invenio/git_hub/client"
require "invenio/pull_request"

module Invenio

  def discover
    Reviewer.run
  end
  module_function :discover
end
