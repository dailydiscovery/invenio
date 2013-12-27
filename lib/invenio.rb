require "invenio/version"

module Invenio

  def discover
    Reviewer.run
  end
  module_function :discover
end
