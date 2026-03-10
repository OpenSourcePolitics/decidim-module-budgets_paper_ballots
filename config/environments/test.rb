# frozen_string_literal: true

require "active_support/core_ext/integer/time"

# The test environment is used exclusively to run your application's
# test suite. You never need to work with it otherwise. Remember that
# your test database is "scratch space" for the test suite and is wiped
# and recreated between test runs. Don't rely on the data there!

# setting added to fix error on github CI
# /home/runner/work/decidim-module-budgets_paper_ballots/decidim-module-budgets_paper_ballots/vendor/bundle/ruby/3.3.0/gems/spring-4.4.2/lib/spring/application.rb:110:in
# `block in preload': Spring reloads, and therefore needs the application to have reloading enabled.
# Please, set config.enable_reloading to true in config/environments/test.rb.
#  (RuntimeError)

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.
  config.cache_classes = false
end
