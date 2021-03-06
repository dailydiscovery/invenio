# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "invenio/version"

Gem::Specification.new do |spec|
  spec.name          = "invenio"
  spec.version       = Invenio::VERSION
  spec.authors       = ["Simeon F. Willbanks"]
  spec.email         = ["sfw@simeonfosterwillbanks.com"]
  spec.description   = ""
  spec.summary       = ""
  spec.homepage      = "https://github.com/dailydiscovery/invenio"
  spec.license       = "MIT"

  spec.files         = %w(
    .ruby-version
    Gemfile
    LICENSE.txt
    README.md
    Rakefile
    invenio.gemspec
    lib/invenio.rb
    lib/invenio/git_hub.rb
    lib/invenio/git_hub/client.rb
    lib/invenio/pull_request.rb
    lib/invenio/reviewer.rb
    lib/invenio/version.rb
    test/invenio/pull_request_test.rb
    test/test_helper.rb
  )

  spec.test_files    = spec.files.grep(%r{^test/})

  spec.add_dependency "octokit", "~> 2.7.0"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
